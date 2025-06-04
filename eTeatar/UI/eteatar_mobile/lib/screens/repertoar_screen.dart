import 'package:eteatar_mobile/models/repertoar.dart';
import 'package:eteatar_mobile/providers/repertoar_provider.dart';
import 'package:eteatar_mobile/screens/predstave_repertoara_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class RepertoarScreen extends StatefulWidget {
  const RepertoarScreen({super.key});

  @override
  State<RepertoarScreen> createState() => _RepertoarScreenState();
}

class _RepertoarScreenState extends State<RepertoarScreen> {
  bool _isLoading = true;
  List<Repertoar> repertoarList = [];
  late RepertoarProvider repertoarProvider;

  @override
  void initState() {
    super.initState();
    repertoarProvider = context.read<RepertoarProvider>();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final result = await repertoarProvider.get();
      setState(() {
        repertoarList = result.resultList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Greška pri dohvatanju repertoara!',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repertoar'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : repertoarList.isEmpty
                ? const Center(child: Text('Nema dostupnih repertoara.'))
                : ListView.builder(
                    itemCount: repertoarList.length,
                    itemBuilder: (context, index) {
                      final rep = repertoarList[index];
                      final datumOd = rep.datumPocetka;
                      final datumDo = rep.datumKraja;
                      final datumOdStr = datumOd != null ? "${datumOd.day}.${datumOd.month}.${datumOd.year}" : "Nepoznato";
                      final datumDoStr = datumDo != null ? "${datumDo.day}.${datumDo.month}.${datumDo.year}" : "Nepoznato";

                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PredstaveRepertoaraScreen(repertoar: rep),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Naziv Repertoara
                                Text(
                                  rep.naziv ?? "Bez naziva",
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 12),

                                // Datum prikazivanja
                                Row(
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        leading: const Icon(Icons.calendar_today, color: Colors.blue, size: 20),
                                        title: const Text("Početak", style: TextStyle(fontSize: 13)),
                                        subtitle: Text(datumOdStr, style: const TextStyle(fontSize: 14)),
                                        visualDensity: VisualDensity.compact,
                                        dense: true,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        leading: const Icon(Icons.calendar_month, color: Colors.green, size: 20),
                                        title: const Text("Kraj", style: TextStyle(fontSize: 13)),
                                        subtitle: Text(datumDoStr, style: const TextStyle(fontSize: 14)),
                                        visualDensity: VisualDensity.compact,
                                        dense: true,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                                      ),
                                    ),
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