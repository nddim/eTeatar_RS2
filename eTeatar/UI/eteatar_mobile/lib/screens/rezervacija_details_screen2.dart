import 'package:eteatar_mobile/models/predstava.dart';
import 'package:eteatar_mobile/models/sjediste.dart';
import 'package:eteatar_mobile/models/termin.dart';
import 'package:eteatar_mobile/providers/dvorana_provider.dart';
import 'package:eteatar_mobile/providers/rezervacija_sjediste_provider.dart';
import 'package:eteatar_mobile/providers/sjediste_provider.dart';
import 'package:eteatar_mobile/screens/rezervacija_details_screen3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RezervacijaDetailsScreen2 extends StatefulWidget {
  final Termin? termin;
  final Predstava? predstava;
  final int? dvoranaId;
  const RezervacijaDetailsScreen2({super.key, required this.predstava, required this.dvoranaId, required this.termin });

  @override
  State<RezervacijaDetailsScreen2> createState() => _RezervacijaDetailsScreen2State();
}

class _RezervacijaDetailsScreen2State extends State<RezervacijaDetailsScreen2> {

  late DvoranaProvider dvoranaProvider;
  late SjedisteProvider sjedisteProvider;
  late RezervacijaSjedisteProvider rezervacijaSjedisteProvider;
  List<Sjediste> sjedista = [];
  final Set<Sjediste> odabrana = {};

  @override
  void initState() {
    super.initState();
    dvoranaProvider = context.read<DvoranaProvider>();
    sjedisteProvider = context.read<SjedisteProvider>();
    rezervacijaSjedisteProvider = context.read<RezervacijaSjedisteProvider>();
    _loadData();
  }

  Future<void> _loadData() async {
    var result = await sjedisteProvider.get(
      filter: {
        'dvoranaId': widget.dvoranaId,
        'isDeleted': false
      }
    );

    var zauzetaSjedistaIds = await rezervacijaSjedisteProvider.getZauzetaSjedista(widget.termin!.terminId!);

    var svi = result.resultList;

    for (var s in svi) {
      if (zauzetaSjedistaIds.contains(s.sjedisteId)) {
        s.status = "Rezervisano";
        s.isZauzeto = true; // samo ako koristiš to interno
      }
    }

    setState(() {
      sjedista = svi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Odaberi sjedišta"), backgroundColor: Colors.lightBlue),
      body: Column(
        children: [
          _buildHeaderInfo(),
          const Divider(thickness: 1),
          const SizedBox(height: 10),
          const Text("Podium", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const Padding(
            padding: EdgeInsets.all(15),
            child: Divider(thickness: 4, color: Colors.black,),
          ),
          const SizedBox(height: 10),
          Expanded(child: _buildSeatGrid()),
          const SizedBox(height: 10),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.image, size: 80),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.predstava!.naziv ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("Datum: ${_formatDatum(widget.predstava!.trajanjePocetak!)}"),
                Text("Vrijeme: ${_formatVrijeme(widget.predstava!.trajanjePocetak!)}"),
                Text("Dvorana: ${widget.dvoranaId}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeatGrid() {
  if (sjedista.isEmpty) {
    return const Center(child: CircularProgressIndicator());
  }

  return SingleChildScrollView(
    child: Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 6,
        runSpacing: 6,
        children: sjedista.map((s) {
          return _buildSeat(s);
        }).toList(),
      ),
    ),
  );
}

//   Widget _buildSeat(String oznaka, String status) {
//   Color boja;
//   if (status == "Rezervisano") {
//     boja = Colors.yellow;
//   } else if (odabrana.contains(oznaka)) {
//     boja = Colors.blue;
//   } else {
//     boja = Colors.grey[400]!;
//   }

//   return GestureDetector(
//     onTap: status == "Rezervisano"
//         ? null
//         : () {
//             setState(() {
//               if (odabrana.contains(oznaka)) {
//                 odabrana.remove(oznaka);
//               } else {
//                 odabrana.add(oznaka);
//               }
//             });
//           },
//     child: Container(
//       width: 40,
//       height: 40,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: boja,
//         borderRadius: BorderRadius.circular(4),
//         border: Border.all(color: Colors.black26),
//       ),
//       child: Text(oznaka, style: const TextStyle(fontSize: 12)),
//     ),
//   );
// }
  Widget _buildSeat(Sjediste s) {
    String oznaka = "${s.red}${s.kolona}";
    Color boja;

    if (s.status == "Rezervisano") {
      boja = Colors.yellow;
    } else if (odabrana.contains(s)) {
      boja = Colors.blue;
    } else {
      boja = Colors.grey[400]!;
    }

    return GestureDetector(
      onTap: s.status == "Rezervisano"
          ? null
          : () {
              setState(() {
                if (odabrana.contains(s)) {
                  odabrana.remove(s);
                } else {
                  odabrana.add(s);
                }
              });
            },
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: boja,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black26),
        ),
        child: Text(oznaka, style: const TextStyle(fontSize: 12)),
      ),
    );
  }
  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Natrag"),
          ),
          ElevatedButton(
            onPressed: odabrana.isEmpty
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RezervacijaDetailsScreen3(
                          predstava: widget.predstava!,
                          dvoranaId: widget.dvoranaId!,
                          odabranaSjedista: odabrana.toList(), // sada je List<Sjediste>
                        ),
                      ),
                    );
                  },
            child: const Text("Nastavi"),
          ),
        ],
      ),
    );
  }

  String _formatDatum(DateTime d) {
    return "${_danUNedjelji(d.weekday)}, ${d.day}.${d.month}.${d.year}";
  }

  String _formatVrijeme(DateTime d) {
    return "${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}h";
  }

  String _danUNedjelji(int broj) {
    const dani = ["Ponedjeljak", "Utorak", "Srijeda", "Četvrtak", "Petak", "Subota", "Nedjelja"];
    return dani[(broj - 1) % 7];
  }
}