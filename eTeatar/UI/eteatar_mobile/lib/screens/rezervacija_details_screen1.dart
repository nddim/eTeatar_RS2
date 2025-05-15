import 'package:eteatar_mobile/models/predstava.dart';
import 'package:eteatar_mobile/models/termin.dart';
import 'package:eteatar_mobile/providers/termin_provider.dart';
import 'package:eteatar_mobile/providers/utils.dart';
import 'package:eteatar_mobile/screens/rezervacija_details_screen2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RezervacijaDetailsScreen1 extends StatefulWidget {
  final Predstava? predstava;
  const RezervacijaDetailsScreen1({super.key, this.predstava});

  @override
  State<RezervacijaDetailsScreen1> createState() => _RezervacijaDetailsScreen1State();
}

class _RezervacijaDetailsScreen1State extends State<RezervacijaDetailsScreen1> {
  late TerminProvider _terminProvider;

  Map<DateTime, List<Termin>> _terminiPoDatumu = {};
  List<DateTime> _dostupniDatumi = [];

  DateTime? _odabraniDatum;
  Termin? _odabraniTermin;

  @override
  void initState() {
    super.initState();
    _terminProvider = context.read<TerminProvider>();
    _loadTermini();
  }

  Future<void> _loadTermini() async {
    var result = await _terminProvider.get(
      filter: {
        'predstavaId': widget.predstava!.predstavaId
      }
    );
    var termini = result.resultList;
    final Map<DateTime, List<Termin>> mapa = {};

    for (var t in termini) {
      if (t.datum != null && t.datum!.isAfter(DateTime.now())) {
        final datum = DateTime(t.datum!.year, t.datum!.month, t.datum!.day);
        mapa.putIfAbsent(datum, () => []).add(t);
      }
    }

    setState(() {
      _terminiPoDatumu = mapa;
      _dostupniDatumi = mapa.keys.toList()..sort();
      if (_dostupniDatumi.isNotEmpty) {
        _odabraniDatum = _dostupniDatumi.first;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rezervacija'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildPredstavaCard(),
            const SizedBox(height: 16),
            _buildDatumi(),
            const SizedBox(height: 12),
            _buildSatnice(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Natrag'),
                ),
                ElevatedButton(
                  onPressed: _odabraniTermin == null ? null : () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RezervacijaDetailsScreen2(predstava: widget.predstava, dvoranaId: _odabraniTermin!.dvoranaId!, termin: _odabraniTermin)));
                  },
                  child: const Text('Nastavi'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPredstavaCard() {
    return Card(
      child: ListTile(
        leading: widget.predstava!.slika != null
            ? imageFromString(widget.predstava!.slika!)
            : const Icon(Icons.image, size: 60),
        title: Text(widget.predstava!.naziv ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Redatelj: ${widget.predstava!.produkcija ?? 'Nepoznato'}")
          ],
        ),
      ),
    );
  }

  Widget _buildDatumi() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _dostupniDatumi.map((datum) {
          final isSelected = datum == _odabraniDatum;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(
                "${_danUTjednu(datum)}, ${_formatDatum(datum)}",
              ),
              selected: isSelected,
              onSelected: (_) {
                setState(() {
                  _odabraniDatum = datum;
                  _odabraniTermin = null;
                });
              },
              selectedColor: Colors.blue,
              backgroundColor: Colors.grey[200],
              labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSatnice() {
    if (_odabraniDatum == null) return const SizedBox();

    final termini = _terminiPoDatumu[_odabraniDatum] ?? [];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: termini.map((termin) {
        final vrijeme = TimeOfDay.fromDateTime(termin.datum!);
        final isSelected = termin == _odabraniTermin;
        final isAktivan = termin.status == "Aktivan";

        return ChoiceChip(
          label: Text("${vrijeme.format(context)}h"),
          selected: isSelected,
          onSelected: isAktivan
              ? (_) {
                  setState(() {
                    _odabraniTermin = termin;
                  });
                }
              : null,
          selectedColor: isAktivan ? Colors.blue : Colors.grey,
          backgroundColor: isAktivan ? Colors.grey[200] : Colors.grey[400],
          labelStyle: TextStyle(
            color: isAktivan
                ? (isSelected ? Colors.white : Colors.black)
                : Colors.black54,
          ),
        );
      }).toList(),
    );
  }

  String _formatDatum(DateTime datum) {
    return "${datum.day}.${datum.month}.${datum.year}.";
  }

  String _danUTjednu(DateTime datum) {
    const dani = ['Pon.', 'Uto.', 'Sri.', 'Čet.', 'Pet.', 'Sub.', 'Ned.'];
    return dani[datum.weekday % 7];
  }
}