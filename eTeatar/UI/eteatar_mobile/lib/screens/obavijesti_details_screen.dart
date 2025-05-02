import 'package:eteatar_mobile/models/vijest.dart';
import 'package:flutter/material.dart';

class ObavijestDetailsScreen extends StatefulWidget {
  Vijest? vijest;
  ObavijestDetailsScreen({super.key, this.vijest});

  @override
  State<ObavijestDetailsScreen> createState() => _ObavijestDetailsScreenState();
}

class _ObavijestDetailsScreenState extends State<ObavijestDetailsScreen> {

   @override
  Widget build(BuildContext context) {
    final vijest = widget.vijest;

    if (vijest == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalji obavijesti')),
        body: const Center(child: Text("Greška: Obavijest nije dostupna.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalji obavijesti'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vijest.naziv ?? "Bez naslova",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Datum: ${vijest.datum?.day ?? '--'}.${vijest.datum?.month ?? '--'}.${vijest.datum?.year ?? '----'}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const Divider(height: 30),
                Text(
                  vijest.sadrzaj ?? "Bez sadržaja",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}