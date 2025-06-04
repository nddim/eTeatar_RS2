import 'package:eteatar_mobile/models/karta_dto.dart';
import 'package:eteatar_mobile/models/termin.dart';
import 'package:eteatar_mobile/providers/karta_dto_provider.dart';
import 'package:eteatar_mobile/providers/termin_provider.dart';
import 'package:eteatar_mobile/providers/utils.dart';
import 'package:eteatar_mobile/screens/karta_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class KarteScreen extends StatefulWidget {
  const KarteScreen({super.key});

  @override
  State<KarteScreen> createState() => _KarteScreenState();
}

class _KarteScreenState extends State<KarteScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  late KartaDtoProvider kartaDtoProvider;
  late TerminProvider terminProvider;
  List<KartaDTO> karte = [];
  List<KartaDTO> archivedKarte = [];
  List<Termin> termini = [];
  Map<int, Termin> terminiMap = {};

  @override
  void initState() {
    kartaDtoProvider = context.read<KartaDtoProvider>();
    terminProvider = context.read<TerminProvider>();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final result = await kartaDtoProvider.getKarte();
      final resultArchived = await kartaDtoProvider.getArchivedKarte();
      var resultTermin = await terminProvider.get(
        filter: {'isDeleted': false}
      );
      termini = resultTermin.resultList;

      terminiMap = {for (var termin in termini) termin.terminId!: termin};

      setState(() {
        karte = result;
        archivedKarte = resultArchived;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Karte'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Aktivne karte'),
            Tab(text: 'Prošle karte'),
          ],
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildKarteList(karte, allowTap: true),         // Aktivne — klik omogućeno
                _buildKarteList(archivedKarte, allowTap: false), // Prošle — klik onemogućen
              ],
            ),
    );
  }

  Widget _buildKarteList(List<KartaDTO> karteZaPrikaz, {required bool allowTap}) {
    if (karteZaPrikaz.isEmpty) {
      return const Center(child: Text("Nema dostupnih karata."));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: karteZaPrikaz.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final karta = karteZaPrikaz[index];
        final termin = terminiMap[karta.terminId];
        final datum = termin?.datum;
        final datumString = datum != null ? "${datum.day}.${datum.month}.${datum.year}" : "Bez datuma";
        final vrijemeString = datum != null ? TimeOfDay.fromDateTime(datum).format(context) : "Vrijeme nepoznato";

        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: InkWell(
            onTap: allowTap
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KartaDetailsScreen(karta: karta),
                      ),
                    );
                  }
                : null,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      karta.nazivPredstave,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Row: Datum i Vrijeme
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: const Icon(Icons.date_range, color: Colors.blue, size: 20),
                          title: const Text("Datum", style: TextStyle(fontSize: 13)),
                          subtitle: Text(datumString, style: const TextStyle(fontSize: 14)),
                          visualDensity: VisualDensity.compact,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                          dense: true,
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          leading: const Icon(Icons.access_time, color: Colors.green, size: 20),
                          title: const Text("Vrijeme", style: TextStyle(fontSize: 13)),
                          subtitle: Text(vrijemeString, style: const TextStyle(fontSize: 14)),
                          visualDensity: VisualDensity.compact,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                          dense: true,
                        ),
                      ),
                    ],
                  ),

                  // Row: Sjediste i Cijena
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: const Icon(Icons.event_seat, color: Colors.deepPurple, size: 20),
                          title: const Text("Sjediste", style: TextStyle(fontSize: 13)),
                          subtitle: Text("Red ${karta.red}, Kolona ${karta.kolona}", style: const TextStyle(fontSize: 14)),
                          visualDensity: VisualDensity.compact,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                          dense: true,
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          leading: const Icon(Icons.attach_money, color: Colors.orange, size: 20),
                          title: const Text("Cijena", style: TextStyle(fontSize: 13)),
                          subtitle: Text("${formatCurrency(karta.cijena)} KM", style: const TextStyle(fontSize: 14)),
                          visualDensity: VisualDensity.compact,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                          dense: true,
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
    );
  }
}