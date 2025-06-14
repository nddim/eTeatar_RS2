import 'package:eteatar_mobile/models/predstava.dart';
import 'package:eteatar_mobile/providers/predstava_provider.dart';
import 'package:eteatar_mobile/screens/arhiva_predstava_detalji_screen.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class ArhivaPredstavaScreen extends StatefulWidget {
  const ArhivaPredstavaScreen({super.key});

  @override
  State<ArhivaPredstavaScreen> createState() => _ArhivaPredstavaScreenState();
}

class _ArhivaPredstavaScreenState extends State<ArhivaPredstavaScreen> {
   List<Predstava> arhiva = [];
  bool _isLoading = true;
  late PredstavaProvider predstavaProvider;

  @override
  void initState() {
    super.initState();
    predstavaProvider = PredstavaProvider();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final result = await predstavaProvider.getProslePredstave();
      setState(() {
        arhiva = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri učitavanju arhive predstava!",
        text: e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arhiva Predstava'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : arhiva.isEmpty
                ? const Center(child: Text('Nema arhiviranih predstava.'))
                : ListView.builder(
                    itemCount: arhiva.length,
                    itemBuilder: (context, index) {
                      final predstava = arhiva[index];
                      final opisPreview = predstava.opis != null
                          ? (predstava.opis!.length > 60 ? '${predstava.opis!.substring(0, 50)}...' : predstava.opis!)
                          : 'Bez opisa';

                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PredstavaDetaljiScreen(predstava: predstava),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  predstava.naziv ?? "Bez naziva",
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  opisPreview,
                                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.schedule, color: Colors.blueGrey, size: 18),
                                    const SizedBox(width: 4),
                                    Text('${predstava.trajanje} min', style: const TextStyle(fontSize: 14)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }

}