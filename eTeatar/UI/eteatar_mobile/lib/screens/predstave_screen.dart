import 'package:eteatar_mobile/models/predstava.dart';
import 'package:eteatar_mobile/providers/predstava_provider.dart';
import 'package:eteatar_mobile/screens/korisnicki_profil_screen.dart';
import 'package:eteatar_mobile/screens/obavijesti_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class PredstavaScreen extends StatefulWidget {
  const PredstavaScreen({super.key});

  @override
  State<PredstavaScreen> createState() => _PredstavaScreenState();
}

class _PredstavaScreenState extends State<PredstavaScreen> {
  
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    try {
      final predstavaResult = await predstavaProvider.get(
        filter: {
          'isDeleted': false,
          if (_searchController.text.isNotEmpty)
            'NazivGTE': _searchController.text,
        },
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
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.person),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const KorisnickiProfil()),
                          );
                        },
                      ),
              const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Pretraži eTeatar',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () => loadData(),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            isDense: true,
                          ),
                          onSubmitted: (value) {
                            loadData();
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.mail_outline),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ObavijestiScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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