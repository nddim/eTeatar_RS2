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
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text(predstava.naziv ?? 'Bez naziva'),
                          subtitle: Text(predstava.opis ?? 'Bez opisa'),
                          trailing: Text('${predstava.trajanjePocetak} min'),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PredstavaDetaljiScreen(predstava: predstava),
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