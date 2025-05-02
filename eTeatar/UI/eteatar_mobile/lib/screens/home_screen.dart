import 'package:eteatar_mobile/models/rezervacija.dart';
import 'package:eteatar_mobile/providers/auth_provider.dart';
import 'package:eteatar_mobile/providers/rezervacija_provider.dart';
import 'package:eteatar_mobile/screens/korisnicki_profil_screen.dart';
import 'package:eteatar_mobile/screens/obavijesti_screen.dart';
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
  late RezervacijaProvider rezervacijaProvider;
  List<Rezervacija> rezervacije = [];

  @override
  void initState() {
    rezervacijaProvider = context.read<RezervacijaProvider>();
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final rezervacijaResult = await rezervacijaProvider.get(
        filter: {
          'korisnikId': AuthProvider.korisnikId,
          'isDeleted': false
        },
      );
      setState(() {
        rezervacije = rezervacijaResult.resultList;
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
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Pretraži eTeatar',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    isDense: true,
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
              )
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildRecommendedCard('Seljačka opera', 'Drama'),
                _buildRecommendedCard('Realisti', 'Opera'),
              ],
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

  Widget _buildRecommendedCard(String title, String genre) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.image, size: 80, color: Colors.grey),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(genre, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
  
}
