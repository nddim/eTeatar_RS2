import 'package:eteatar_mobile/models/predstava.dart';
import 'package:eteatar_mobile/providers/utils.dart';
import 'package:eteatar_mobile/screens/rezervacija_details_screen1.dart';
import 'package:flutter/material.dart';

class PredstavaDetaljiScreen2 extends StatefulWidget {
  final Predstava? predstava;
  const PredstavaDetaljiScreen2({super.key, this.predstava});

  @override
  State<PredstavaDetaljiScreen2> createState() => _PredstavaDetaljiScreen2State();
}

class _PredstavaDetaljiScreen2State extends State<PredstavaDetaljiScreen2> {
   @override
  Widget build(BuildContext context) {
    final p = widget.predstava;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalji predstave"),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kartica s cijelim sadržajem
            _buildDetailsCard(context, p),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard(BuildContext context, Predstava? p) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            if (p?.slika != null)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: imageFromString(p!.slika!),
                ),
              )
            else
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.image, size: 60)),
                ),
              ),
            const SizedBox(height: 16),
            
            Text(p?.naziv ?? '', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            
            Text(p?.opis ?? '', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            
            Text("Produkcija: ${p?.produkcija ?? 'Nepoznato'}"),
            Text("Koreografija: ${p?.koreografija ?? 'Nepoznato'}"),
            Text("Scenografija: ${p?.scenografija ?? 'Nepoznato'}"),
            Text("Trajanje: ${p?.trajanje ?? 'Nepoznato'} min"),
            const SizedBox(height: 24),
            
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RezervacijaDetailsScreen1(predstava: p)),
                  );
                },
                child: const Text("Rezerviši"),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}