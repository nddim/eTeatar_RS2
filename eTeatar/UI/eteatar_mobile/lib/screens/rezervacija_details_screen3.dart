import 'package:eteatar_mobile/models/predstava.dart';
import 'package:eteatar_mobile/models/sjediste.dart';
import 'package:eteatar_mobile/models/termin.dart';
import 'package:eteatar_mobile/providers/auth_provider.dart';
import 'package:eteatar_mobile/providers/rezervacija_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class RezervacijaDetailsScreen3 extends StatefulWidget {
  final Termin? termin;
  final Predstava? predstava;
  final int? dvoranaId;
   final List<Sjediste> odabranaSjedista;

  const RezervacijaDetailsScreen3({super.key, required this.predstava, required this.dvoranaId, required this.odabranaSjedista, required this.termin});

  @override
  State<RezervacijaDetailsScreen3> createState() => _RezervacijaDetailsScreen3State();
}

class _RezervacijaDetailsScreen3State extends State<RezervacijaDetailsScreen3> {

  late RezervacijaProvider rezervacijaProvider;

  @override
  void initState() {
    super.initState();
    rezervacijaProvider = context.read<RezervacijaProvider>();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pregled rezervacije'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Predstava: ${widget.predstava!.naziv}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Datum: ${_formatDatum(widget.predstava!.trajanjePocetak!)}"),
            Text("Vrijeme: ${_formatVrijeme(widget.predstava!.trajanjePocetak!)}"),
            Text("Dvorana: ${widget.dvoranaId}"),
            const SizedBox(height: 16),
            const Text("Odabrana sjedišta:", style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: widget.odabranaSjedista
                  .map((s) => Chip(label: Text("${s.red}${s.kolona}")))
                  .toList(),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                 _rezervisi(context);
                },
                child: const Text("Rezerviši"),
              ),
            )
          ],
        ),
      ),
    );
  }
  void _rezervisi(BuildContext context) async {
    try {
      List<int> sjedistaIds = widget.odabranaSjedista.map((s) => s.sjedisteId!).toList();
      var request = {
         "status": "Rezervisano",
        "terminId": widget.termin!.terminId!,
        "sjedista": sjedistaIds,
        "korisnikId": AuthProvider.korisnikId,
      };
      await rezervacijaProvider.insert(request);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: "Uspjeh",
        text: "Rezervacija je uspješno izvršena!",
        confirmBtnText: "Zatvori",
        onConfirmBtnTap: () => Navigator.popUntil(context, (route) => route.isFirst),
      );
    } catch (e) {
      print(e);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška",
        text: "Došlo je do greške pri rezervaciji. Pokušajte ponovo.",
      );
    }
  }

  String _formatDatum(DateTime d) {
    return "${d.day}.${d.month}.${d.year}";
  }

  String _formatVrijeme(DateTime d) {
    return "${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}h";
  }
}