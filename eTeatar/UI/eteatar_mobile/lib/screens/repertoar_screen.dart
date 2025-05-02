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
                      final datumOd = "${rep.datumPocetka!.day}.${rep.datumPocetka!.month}.${rep.datumPocetka!.year}";
                      final datumDo = "${rep.datumKraja!.day}.${rep.datumKraja!.month}.${rep.datumKraja!.year}";

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text(rep.naziv ?? 'Bez naziva'),
                          subtitle: Text('Od $datumOd do $datumDo'),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PredstaveRepertoaraScreen(repertoar: rep),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}