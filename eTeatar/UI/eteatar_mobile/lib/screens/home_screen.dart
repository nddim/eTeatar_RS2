import 'package:eteatar_mobile/layouts/master_screen.dart';
import 'package:eteatar_mobile/models/predstava.dart';
import 'package:eteatar_mobile/models/rezervacija.dart';
import 'package:eteatar_mobile/models/search_result.dart';
import 'package:eteatar_mobile/models/termin.dart';
import 'package:eteatar_mobile/providers/auth_provider.dart';
import 'package:eteatar_mobile/providers/korisnik_provider.dart';
import 'package:eteatar_mobile/providers/predstava_provider.dart';
import 'package:eteatar_mobile/providers/rezervacija_provider.dart';
import 'package:eteatar_mobile/providers/termin_provider.dart';
import 'package:eteatar_mobile/screens/korisnicki_profil_screen.dart';
import 'package:eteatar_mobile/screens/obavijesti_screen.dart';
import 'package:eteatar_mobile/screens/predstava_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool _isLoading = true;
  late KorisnikProvider korisnikProvider;
  late PredstavaProvider predstavaProvider;
  late RezervacijaProvider rezervacijaProvider;
  late TerminProvider terminProvider;
  List<Rezervacija> rezervacije = [];
  List<Termin> termini = [];
  List<Predstava> preporucenePredstave = [];
  SearchResult<Predstava>? predstavaResult;
  @override
  void initState() {
    korisnikProvider = context.read<KorisnikProvider>();
    rezervacijaProvider = context.read<RezervacijaProvider>();
    terminProvider = context.read<TerminProvider>();
    predstavaProvider = context.read<PredstavaProvider>();
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final terminResult = await terminProvider.get(
        filter: {
          'isDeleted': false,
        },
      );
      
      final rezervacijaResult = await rezervacijaProvider.get(
        filter: {
          'korisnikId': AuthProvider.korisnikId,
          'isDeleted': false
        },
      );

      predstavaResult = await predstavaProvider.get(
        filter: {
          'isDeleted': false,
        },
      );

      try {
        final korisnikResult = await korisnikProvider.recommend();
        preporucenePredstave = korisnikResult;
      }
      catch (e) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Greška pri dohvatanju preporučenih predstava!"
        );
      };
      final Map<int, Termin> terminMap = {
        for (var t in terminResult.resultList) t.terminId!: t
      };

      final Map<int, dynamic> _predstavaCache = {};

      for (var rez in rezervacijaResult.resultList) {
        final termin = terminMap[rez.terminId];
        rez.termin = termin;

        if (termin != null) {
          final predstavaId = termin.predstavaId;
          if (predstavaId != null) {
            if (!_predstavaCache.containsKey(predstavaId)) {
              try {
                final predstava = await predstavaProvider.getById(predstavaId);
                _predstavaCache[predstavaId] = predstava;
              } catch (e) {
                debugPrint("Greška pri dohvaćanju predstave: $e");
                _predstavaCache[predstavaId] = null;
              }
            }
            termin.predstava = _predstavaCache[predstavaId];
          }
        }
      }

      setState(() {
        rezervacije = rezervacijaResult.resultList;
        termini = terminResult.resultList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju podataka!"
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              Expanded( // <-- Omogućava dugmetu da se raširi
                child: TextButton(
                  onPressed: () {
                    MasterScreen.of(context)?.changeTab(1); // Ide na predstave
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16), // Povećano za bolji izgled
                  ),
                  child: const Text(
                    "Pogledaj sve predstave →",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
          const Text(
            'PREPORUČENO',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : preporucenePredstave.isEmpty
                    ? const Center(child: Text("Nema preporučenih predstava."))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: preporucenePredstave.length,
                        itemBuilder: (context, index) {
                          final predstava = preporucenePredstave[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PredstavaDetaljiScreen2(predstava: predstava),
                                ),
                              );
                            },
                            child: _buildRecommendedCard(
                              predstava.naziv ?? "Bez naziva",
                              predstava.trajanje,
                            ),
                          );
                        },
                        
                      ),
                      
          ),
          const SizedBox(height: 20),
          const Text(
            'REZERVACIJE',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : rezervacije.isEmpty
                  ? const Text('Nemate aktivnih rezervacija.')
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: rezervacije.length,
                      itemBuilder: (context, index) {
                        final rez = rezervacije[index];
                        final datumObj = rez.termin?.datum;
                        final datum = datumObj != null
                            ? "${datumObj.day}.${datumObj.month}.${datumObj.year}"
                            : "Bez datuma";
                        final vrijeme = datumObj != null
                            ? TimeOfDay.fromDateTime(datumObj).format(context)
                            : "Vrijeme nepoznato";
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            title: Text('${rez.termin?.predstava?.naziv ?? 'Predstava'}'),
                            subtitle: Text(datum),
                            trailing: Text(
                              vrijeme,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    ),
        ],
      ),
    );
  }

  Widget _buildRecommendedCard(String title, int? trajanje) {
   
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.theaters, size: 80, color: Colors.grey),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              'Trajanje: ${trajanje.toString()} min',
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
  
}
