import 'package:eteatar_mobile/models/rezervacija.dart';
import 'package:eteatar_mobile/models/termin.dart';
import 'package:eteatar_mobile/providers/auth_provider.dart';
import 'package:eteatar_mobile/providers/rezervacija_provider.dart';
import 'package:eteatar_mobile/providers/termin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class RezervacijeScreen extends StatefulWidget {
  const RezervacijeScreen({super.key});

  @override
  State<RezervacijeScreen> createState() => _RezervacijeScreenState();
}

class _RezervacijeScreenState extends State<RezervacijeScreen> {
  bool _isLoading = true;
  late RezervacijaProvider rezervacijaProvider;
  late TerminProvider terminProvider;
  List<Termin> termini = [];
  List<Rezervacija> rezervacije = [];
  String searchQuery = '';

  @override
  void initState() {
    rezervacijaProvider = context.read<RezervacijaProvider>();
    terminProvider = context.read<TerminProvider>();
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final terminResult = await terminProvider.get(
        filter: {
          'isDeleted': false,
        },
      );

      final rezervacijaResult = await rezervacijaProvider.get(
        filter: {
          'korisnikId': AuthProvider.korisnikId,
          'isDeleted': false
        },
      );

      final Map<int, Termin> terminMap = {
        for (var t in terminResult.resultList) t.terminId!: t
      };

      for (var rez in rezervacijaResult.resultList) {
        rez.termin = terminMap[rez.terminId];
      }
      setState(() {
        rezervacije = rezervacijaResult.resultList;
        termini = terminResult.resultList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju rezervacija!",
      );
    }
  }

  List<Rezervacija> get filteredRezervacije {
    if (searchQuery.isEmpty) return rezervacije;
    return rezervacije
        .where((rez) => rez.termin?.predstava?.naziv
            ?.toLowerCase()
            .contains(searchQuery.toLowerCase()) ?? false)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moje rezervacije'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredRezervacije.isEmpty
                      ? const Text('Nema pronađenih rezervacija.')
                      : ListView.builder(
                          itemCount: filteredRezervacije.length,
                          itemBuilder: (context, index) {
                            final rez = filteredRezervacije[index];
                            final datumObj = rez.termin?.datum;
                            final datum = datumObj != null
                                ? "${datumObj.day}.${datumObj.month}.${datumObj.year}"
                                : "Bez datuma";
                            final vrijeme = datumObj != null
                                ? TimeOfDay.fromDateTime(datumObj).format(context)
                                : "Vrijeme nepoznato";

                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ListTile(
                                title: Text('${rez.termin?.predstava?.naziv ?? 'Predstava'}'),
                                subtitle: Text(datum),
                                trailing: Text(
                                  vrijeme,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}