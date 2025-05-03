import 'package:eteatar_mobile/models/predstava.dart';
import 'package:eteatar_mobile/models/repertoar.dart';
import 'package:eteatar_mobile/providers/predstava_provider.dart';
import 'package:eteatar_mobile/screens/predstava_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class PredstaveRepertoaraScreen extends StatefulWidget {
  final Repertoar? repertoar;
  const PredstaveRepertoaraScreen({super.key, this.repertoar});

  @override
  State<PredstaveRepertoaraScreen> createState() => _PredstaveRepertoaraScreenState();
}

class _PredstaveRepertoaraScreenState extends State<PredstaveRepertoaraScreen> {
  String selectedSort = 'Relevantnost';
  bool _isLoading = true;
  late PredstavaProvider predstavaProvider;
  List<Predstava> predstave = [];
  int total = 0;

  @override
  void initState() {
    predstavaProvider = context.read<PredstavaProvider>();
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final predstavaResult = await predstavaProvider.get(
        filter: {
          'isDeleted': false,
          if (widget.repertoar != null)
            'repertoarId': widget.repertoar!.repertoarId,
        }
      );
      setState(() {
        predstave = predstavaResult.resultList;
        total = predstavaResult.count;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju predstava!",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predstave'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ukupno: ${predstave.length}'),
                      DropdownButton<String>(
                        value: selectedSort,
                        items: const [
                          DropdownMenuItem(value: 'Relevantnost', child: Text('Relevantnost')),
                          DropdownMenuItem(value: 'Datum', child: Text('Datum')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedSort = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: predstave.length,
                      itemBuilder: (context, index) {
                        final item = predstave[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.theater_comedy_outlined),
                            ),
                            title: Text(item.naziv ?? 'Bez naziva'),
                            subtitle: Text(item.trajanjePocetak != null
                                ? '${item.trajanjePocetak!.day}.${item.trajanjePocetak!.month}.${item.trajanjePocetak!.year}'
                                : 'Bez datuma'),
                            onTap: () {
                              // Navigacija na ekran detalja predstave
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PredstavaDetaljiScreen2(predstava: item),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}