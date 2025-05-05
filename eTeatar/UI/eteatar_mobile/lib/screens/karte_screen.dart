import 'package:eteatar_mobile/models/karta_dto.dart';
import 'package:eteatar_mobile/models/termin.dart';
import 'package:eteatar_mobile/providers/karta_dto_provider.dart';
import 'package:eteatar_mobile/providers/termin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class KarteScreen extends StatefulWidget {
  const KarteScreen({super.key});

  @override
  State<KarteScreen> createState() => _KarteScreenState();
}

class _KarteScreenState extends State<KarteScreen> {
  bool _isLoading = true;
  late KartaDtoProvider kartaDtoProvider;
  late TerminProvider terminProvider;
  List<KartaDTO> karte = [];
  List<Termin> termini = [];
  Map<int, Termin> terminiMap = {};

  @override
  void initState() {
    kartaDtoProvider = context.read<KartaDtoProvider>();
    terminProvider = context.read<TerminProvider>();
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final result = await kartaDtoProvider.getKarte();

      var resultTermin = await terminProvider.get(
        filter: {'isDeleted': false}
      );
      termini = resultTermin.resultList;

      terminiMap = {for (var termin in termini) termin.terminId!: termin};

      setState(() {
        karte = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju karata!",
      );
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Karte'),
  //       leading: IconButton(
  //         icon: const Icon(Icons.arrow_back),
  //         onPressed: () => Navigator.pop(context),
  //       ),
  //       backgroundColor: Colors.lightBlue,
  //     ),
  //     body: _isLoading
  //         ? const Center(child: CircularProgressIndicator())
  //         : karte.isEmpty
  //           ? const Center(child: Text("Nema dostupnih karata."))
  //           : ListView.separated(
  //               padding: const EdgeInsets.all(16),
  //               itemCount: karte.length,
  //               separatorBuilder: (_, __) => const SizedBox(height: 12),
  //               itemBuilder: (context, index) {
  //                 final karta = karte[index];

  //                 final termin = terminiMap[karta.terminId];

  //                 return ListTile(
  //                   tileColor: Colors.grey[100],
  //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //                   leading: const Icon(Icons.message_outlined),
  //                   title: Text('Karta ID: ${karta.kartaId}'),
  //                   subtitle: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text('Cijena: ${karta.cijena} KM'),
  //                       Text('Predstava: ${karta.nazivPredstave }'),
  //                       Text('Datum: ${termin?.datum?.toLocal() ?? 'Nema datuma'}'),
  //                       Text('Sjediste: R${karta.sjedisteId}, K${karta.sjedisteId}')
  //                     ],
  //                   ),
  //                 );
  //               },
  //             ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Karte'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : karte.isEmpty
              ? const Center(child: Text("Nema dostupnih karata."))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: karte.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final karta = karte[index];

                    final termin = terminiMap[karta.terminId];

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        title: Text(
                          'Karta ID: ${karta.kartaId}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cijena: ${karta.cijena} KM'),
                            Text('Predstava: ${karta.nazivPredstave}'),
                            Text('Datum: ${termin?.datum?.toLocal().toString() ?? 'Nema datuma'}'),
                            Text('Sjediste: R${karta.sjedisteId}, K${karta.sjedisteId}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}