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

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
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
            contentPadding: const EdgeInsets.all(12),
            title: Text(
              karta.nazivPredstave,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cijena: ${formatCurrency(karta.cijena)} KM'),
                Text('Datum: ${termin?.datum == null ? 'Nema datuma' : formatDateTime(termin!.datum!.toString())}'),
                Text('Sjediste: Red ${karta.red}, Kolona ${karta.kolona}'),
              ],
            ),
          ),
        );
      },
    );
  }
}