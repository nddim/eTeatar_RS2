import 'package:eteatar_mobile/models/karta_dto.dart';
import 'package:eteatar_mobile/providers/karta_provider.dart';
import 'package:eteatar_mobile/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class KartaDetailsScreen extends StatefulWidget {
  final KartaDTO? karta;
  const KartaDetailsScreen({super.key, this.karta});

  @override
  State<KartaDetailsScreen> createState() => _KartaDetailsScreenState();
}

class _KartaDetailsScreenState extends State<KartaDetailsScreen> {
  late KartaProvider kartaProvider;
  bool? ukljucenaHrana = false;

  @override
  void initState() {
    kartaProvider = context.read<KartaProvider>();
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final result = await kartaProvider.getById(widget.karta!.kartaId);
      setState(() {
        ukljucenaHrana = result.ukljucenaHrana;
      });
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju karata!",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalji karte'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Detalji karte',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    detailRow(Icons.attach_money, 'Cijena', '${formatCurrency(widget.karta!.cijena)} KM'),
                    detailRow(Icons.theater_comedy, 'Predstava', widget.karta!.nazivPredstave),
                    detailRow(Icons.date_range, 'Datum', formatDateTime(widget.karta!.datumVrijeme.toLocal().toString())),
                    detailRow(Icons.event_seat, 'Sjediste', 'Red ${widget.karta!.red}, Kolona ${widget.karta!.kolona}'),
                    const SizedBox(height: 10),
                    // ✅ Novi red za "Uključena hrana"
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.fastfood, color: Colors.blue),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              "Uključena hrana",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Checkbox(
                            value: ukljucenaHrana,
                            onChanged: (bool? value) {
                              setState(() {
                                ukljucenaHrana = value ?? false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () async {
                  try {
                    var request = {
                      "ukljucenaHrana": ukljucenaHrana,
                      'cijena': widget.karta!.cijena,
                      'terminId': widget.karta!.terminId,
                      'sjedisteId': widget.karta!.sjedisteId
                    };
                    print(request);
                    await kartaProvider.update(widget.karta!.kartaId, request);
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      title: "Uspješno spasena karta!",
                    );
                  } catch (e) {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: "Greška",
                      text: "Došlo je do greške pri izmjene karte. Pokušajte ponovo.",
                    );
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text("Sačuvaj kartu"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget detailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Icon(icon, color: Colors.blue, size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}