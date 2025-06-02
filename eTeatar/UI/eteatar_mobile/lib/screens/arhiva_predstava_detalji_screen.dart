import 'package:eteatar_mobile/models/predstava.dart';
import 'package:eteatar_mobile/providers/auth_provider.dart';
import 'package:eteatar_mobile/providers/ocjena_provider.dart';
import 'package:eteatar_mobile/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class PredstavaDetaljiScreen extends StatefulWidget {
  final Predstava? predstava;
  const PredstavaDetaljiScreen({super.key, this.predstava});

  @override
  State<PredstavaDetaljiScreen> createState() => _PredstavaDetaljiScreenState();
}

class _PredstavaDetaljiScreenState extends State<PredstavaDetaljiScreen> {
  late OcjenaProvider ocjenaProvider;
  double? _prosjekOcjena;
  bool _isRatingLoading = true;
  bool _isCheckingOcjena = true;

  @override
  void initState() {
    super.initState();
    ocjenaProvider = context.read<OcjenaProvider>();
    fetchAverageRating();
    jelKorisnikOcjenio();
  }

  final _komentarController = TextEditingController();
  double _ocjena = 5.0;
  bool _jelKorisnikOcjenio = false;
  @override
  void dispose() {
    _komentarController.dispose();
    super.dispose();
  }
  Future<void> fetchAverageRating() async {
  try {
    final result = await ocjenaProvider.getProsjecnaOcjena(widget.predstava!.predstavaId!);
    if (!mounted) return;
    setState(() {
      _prosjekOcjena = result.toDouble();
      _isRatingLoading = false;
    });
    } catch (e) {
      setState(() {
        _isRatingLoading = false;
      });
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju prosječne ocjene!",
        text: "$e",
      );
    }
  }

  Future<void> jelKorisnikOcjenio() async {
  try {
    final result = await ocjenaProvider.jelKorisnikOcjenio(
      AuthProvider.korisnikId!, 
      widget.predstava!.predstavaId!
    );
    setState(() {
      _jelKorisnikOcjenio = result;
      _isCheckingOcjena = false;
    });
  } catch (e) {
    setState(() {
      _jelKorisnikOcjenio = false;
      _isCheckingOcjena = false;
    });
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: "Greška pri provjeri ocjene!",
      text: "$e",
    );
  }
}

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
            if (p!.slika != null)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: imageFromString(p.slika!),
                ),
              )
            else
              Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(child: Icon(Icons.image, size: 60)),
              ),
            const SizedBox(height: 16),
            Text(p.naziv ?? '', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(p.opis ?? '', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text("Produkcija: ${p.produkcija ?? 'Nepoznato'}"),
            Text("Koreografija: ${p.koreografija ?? 'Nepoznato'}"),
            Text("Scenografija: ${p.scenografija ?? 'Nepoznato'}"),
            const SizedBox(height: 12),
            _isRatingLoading ? const CircularProgressIndicator()
              : _prosjekOcjena != null ? 
              Row( 
                children: [
                  const Text("Prosječna ocjena: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  RatingBarIndicator(
                    rating: _prosjekOcjena!,
                    itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 24.0,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(width: 8),
                  Text(_prosjekOcjena!.toStringAsFixed(1)),
                ],
              )
            : const Text("Još nema ocjena za ovu predstavu."),
            const SizedBox(height: 24),
            _buildRatingCard()
          ],
        ),
      ),
    );
  }

  Widget _buildRatingCard() {
    if (_isCheckingOcjena) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_jelKorisnikOcjenio) {
      return const Text(
        "Već ste ocijenili ovu predstavu.",
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
      );
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Ostavi ocjenu", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            RatingBar.builder(
              initialRating: _ocjena,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                setState(() {
                  _ocjena = rating;
                });
              },
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _komentarController,
              decoration: const InputDecoration(
                labelText: "Komentar",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () async {
                  final request = {
                    "korisnikId": AuthProvider.korisnikId,
                    "predstavaId": widget.predstava!.predstavaId,
                    "vrijednost": _ocjena.toInt(),
                    "komentar": _komentarController.text,
                  };
                  try {
                    await ocjenaProvider.insert(request);
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      title: "Uspješno dodata ocjena!",
                    );
                    _komentarController.clear();
                    setState(() {
                      _ocjena = 5;
                      _jelKorisnikOcjenio = true;
                    });
                    await fetchAverageRating();
                  } catch (e) {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: "Greška pri dodavanju ocjene!",
                      text: "$e",
                    );
                  }
                },
                child: const Text("Sačuvaj ocjenu"),
              ),
            )
          ],
        ),
      ),
    );
  }
}