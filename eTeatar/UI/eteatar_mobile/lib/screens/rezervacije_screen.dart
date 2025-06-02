import 'package:eteatar_mobile/models/rezervacija.dart';
import 'package:eteatar_mobile/models/termin.dart';
import 'package:eteatar_mobile/providers/auth_provider.dart';
import 'package:eteatar_mobile/providers/rezervacija_provider.dart';
import 'package:eteatar_mobile/providers/rezervacija_sjediste_provider.dart';
import 'package:eteatar_mobile/providers/termin_provider.dart';
import 'package:eteatar_mobile/providers/predstava_provider.dart';
import 'package:eteatar_mobile/providers/uplata_provider.dart';
import 'package:eteatar_mobile/providers/stavka_uplate_provider.dart'; 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

class RezervacijeScreen extends StatefulWidget {
  String? secret;
  String? public;
  String? sandBoxMode;

  RezervacijeScreen({super.key}){
    secret = const String.fromEnvironment("_paypalSecret", defaultValue: "");
    public = const String.fromEnvironment("_paypalPublic", defaultValue: "");
    sandBoxMode = const String.fromEnvironment("_sandBoxMode", defaultValue: "true");
  }
  
  @override
  State<RezervacijeScreen> createState() => _RezervacijeScreenState();
}

class _RezervacijeScreenState extends State<RezervacijeScreen> {
  bool _isLoading = true;
  late RezervacijaProvider rezervacijaProvider;
  late TerminProvider terminProvider;
  late PredstavaProvider predstavaProvider;
  late UplataProvider uplataProvider;
  late StavkaUplateProvider stavkaUplateProvider;
  late RezervacijaSjedisteProvider rezervacijaSjedisteProvider;
  List<Termin> termini = [];
  List<Rezervacija> rezervacije = [];
  String searchQuery = '';
  Map<int, int> brojSjedistaPoRezervaciji = {};
  
  @override
  void initState() {
    rezervacijaProvider = context.read<RezervacijaProvider>();
    terminProvider = context.read<TerminProvider>();
    predstavaProvider = context.read<PredstavaProvider>();
    uplataProvider = context.read<UplataProvider>();
    stavkaUplateProvider = context.read<StavkaUplateProvider>();
    rezervacijaSjedisteProvider = context.read<RezervacijaSjedisteProvider>();
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

      final Map<int, Termin> terminMap = {
        for (var t in terminResult.resultList) t.terminId!: t
      };

      final Map<int, dynamic> predstavaCache = {}; 

      for (var termin in terminMap.values) {
        final pid = termin.predstavaId;
        if (termin.predstava == null && pid != null) {
          if (!predstavaCache.containsKey(pid)) {
            try {
              final predstava = await predstavaProvider.getById(pid);
              predstavaCache[pid] = predstava;
            } catch (e) {
              debugPrint('Greška pri dohvaćanju predstave za ID $pid: $e');
              predstavaCache[pid] = null; 
            }
          }
          termin.predstava = predstavaCache[pid];
        }
      }

      for (var rez in rezervacijaResult.resultList) {
        rez.termin = terminMap[rez.terminId];
        var sjedistaResult = await rezervacijaSjedisteProvider.get(
          filter: {'RezervacijaId': rez.rezervacijaId}
        );
        brojSjedistaPoRezervaciji[rez.rezervacijaId!] = sjedistaResult.resultList.length;
      }
      setState(() {
        rezervacije = rezervacijaResult.resultList;
        termini = terminResult.resultList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju rezervacija!",
      );
    }
  }

  List<Rezervacija> get filteredRezervacije {
    if (searchQuery.isEmpty) return rezervacije;
    return rezervacije
        .where((rez) => rez.termin?.predstava?.naziv
            ?.toLowerCase()
            .contains(searchQuery.toLowerCase()) ?? false)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moje rezervacije'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredRezervacije.isEmpty
                      ? const Text('Nema pronađenih rezervacija.')
                      : ListView.builder(
                          itemCount: filteredRezervacije.length,
                          itemBuilder: (context, index) {
                            final rez = filteredRezervacije[index];
                            final datumObj = rez.termin?.datum;
                            final status = rez.stateMachine;
                            final datum = datumObj != null
                                ? "${datumObj.day}.${datumObj.month}.${datumObj.year}"
                                : "Bez datuma";
                            final vrijeme = datumObj != null
                                ? TimeOfDay.fromDateTime(datumObj).format(context)
                                : "Vrijeme nepoznato";

                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Text(
                                        rez.termin?.predstava?.naziv ?? 'Predstava',
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(height: 12),

                                    ListTile(
                                      leading: const Icon(Icons.date_range, color: Colors.blue, size: 20),
                                      title: const Text("Datum", style: TextStyle(fontSize: 13)),
                                      subtitle: Text(datum, style: const TextStyle(fontSize: 14)),
                                      visualDensity: VisualDensity.compact,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                                      dense: true,
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.access_time, color: Colors.green, size: 20),
                                      title: const Text("Vrijeme", style: TextStyle(fontSize: 13)),
                                      subtitle: Text(vrijeme, style: const TextStyle(fontSize: 14)),
                                      visualDensity: VisualDensity.compact,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                                      dense: true,
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.event_seat, color: Colors.deepPurple, size: 20),
                                      title: const Text("Broj sjedišta", style: TextStyle(fontSize: 13)),
                                      subtitle: Text("${brojSjedistaPoRezervaciji[rez.rezervacijaId] ?? 0}", style: const TextStyle(fontSize: 14)),
                                      visualDensity: VisualDensity.compact,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                                      dense: true,
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.info_outline, color: Colors.orange, size: 20),
                                      title: const Text("Status", style: TextStyle(fontSize: 13)),
                                      subtitle: Text(status!, style: const TextStyle(fontSize: 14)),
                                      visualDensity: VisualDensity.compact,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                                      dense: true,
                                    ),

                                    const SizedBox(height: 8),
                                    if (rez.stateMachine != "Ponisteno" && rez.stateMachine != "Zavrseno")
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            if (rez.stateMachine != "Odobreno") {
                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.warning,
                                                title: "Upozorenje",
                                                text: "Rezervacija nije odobrena!",
                                              );
                                              return;
                                            }
                                            makePayment(rez);
                                          },
                                          icon: const Icon(Icons.payment),
                                          label: const Text('Plati'),
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
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

  Future<void> makePayment(Rezervacija rezervacija) async {
    final secret = dotenv.env['_paypalSecret'];
    final public = dotenv.env['_paypalPublic'];

     var valueSecret =
        (widget.secret == "" || widget.secret == null) ? secret : widget.secret;
    var valuePublic =
        (widget.public == "" || widget.public == null) ? public : widget.public;

    if ((valueSecret?.isEmpty ?? true) || (valuePublic?.isEmpty ?? true)) {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Greška",
          text: "Greška sa plaćanjem");
      return;
    }

    try {
      // Osiguraj da je predstava učitana (ako nije, dohvati ručno)
      final predstava = await predstavaProvider.getById(rezervacija.termin!.predstavaId!);
      if (predstava == null || predstava.cijena == null) {
        // Ovdje ubaci dohvat predstave byId ako već nisi
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Greška",
          text: "Podaci o predstavi nisu dostupni.",
        );
        return;
      }

      final naziv = predstava.naziv ?? 'Predstava';
      final brojSjedista = brojSjedistaPoRezervaciji[rezervacija.rezervacijaId] ?? 0;
      final ukupnaCijena = (predstava.cijena! * brojSjedista).toStringAsFixed(2);
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaypalCheckoutView(
            sandboxMode: true,
            clientId: valuePublic,
            secretKey: valueSecret,
            transactions: [
              {
                "amount": {
                  "total": ukupnaCijena,
                  "currency": "USD",
                  "details": {
                    "subtotal": ukupnaCijena,
                    "shipping": '0',
                    "shipping_discount": 0
                  }
                },
                "description": "Plaćanje za rezervaciju - $naziv",
                "item_list": {
                  "items": [
                    {
                      "name": naziv,
                      "quantity": 1,
                      "price": ukupnaCijena,
                      "currency": "USD"
                    }
                  ],
                }
              }
            ],
            note: "Hvala na rezervaciji!",
            onSuccess: (Map params) async {
              await rezervacijaProvider.zavrsiRezervaciju(rezervacija.rezervacijaId!);
              var data = params['data'];
              var placanje = data['payer'];
              var request = {
                'Iznos': ukupnaCijena,
                'korisnikId': AuthProvider.korisnikId,
                'transakcijaId' : data['id'],
                'nacinPlacanja': placanje['payment_method'],
                'status': data['state'],
              };
              var uplata = await uplataProvider.insert(request);
              var stavkaUplateRequest = {
                'cijena': ukupnaCijena,
                'uplataId': uplata.uplataId,
                'kolicina': brojSjedista
              };
              await stavkaUplateProvider.insert(stavkaUplateRequest);
              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: "Uspješno plaćanje!",
                text: "Uplata je uspjesno izvršena!",
                 onConfirmBtnTap: () {
                  Navigator.of(context).pop(); // zatvara alert
                  Navigator.of(context).pop(); // vraća se s PayPal checkout ekrana
                },
              );
            },
            onError: (error) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: "Greška pri plaćanju",
                text: error.toString(),
              );
            },
            onCancel: () {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.info,
                title: "Plaćanje otkazano",
              );
            },
          ),
        ),
      );
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška",
        text: "Došlo je do greške: ${e.toString()}",
      );
    }
  }

}