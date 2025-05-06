import 'package:eteatar_mobile/models/rezervacija.dart';
import 'package:eteatar_mobile/models/termin.dart';
import 'package:eteatar_mobile/providers/auth_provider.dart';
import 'package:eteatar_mobile/providers/rezervacija_provider.dart';
import 'package:eteatar_mobile/providers/termin_provider.dart';
import 'package:eteatar_mobile/providers/predstava_provider.dart';
import 'package:eteatar_mobile/providers/uplata_provider.dart';
import 'package:eteatar_mobile/screens/uplate_screen.dart';
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
  List<Termin> termini = [];
  List<Rezervacija> rezervacije = [];
  String searchQuery = '';

  @override
  void initState() {
    rezervacijaProvider = context.read<RezervacijaProvider>();
    terminProvider = context.read<TerminProvider>();
    predstavaProvider = context.read<PredstavaProvider>();
    uplataProvider = context.read<UplataProvider>();
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

      for (var rez in rezervacijaResult.resultList) {
        rez.termin = terminMap[rez.terminId];
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
                            final datum = datumObj != null
                                ? "${datumObj.day}.${datumObj.month}.${datumObj.year}"
                                : "Bez datuma";
                            final vrijeme = datumObj != null
                                ? TimeOfDay.fromDateTime(datumObj).format(context)
                                : "Vrijeme nepoznato";

                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      rez.termin?.predstava?.naziv ?? 'Predstava',
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Datum: $datum'),
                                            Text('Vrijeme: $vrijeme'),
                                          ],
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (rez.stateMachine == "Zavrsena"){
                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.error,
                                                title: "Greška",
                                                text: "Rezervacija je zavrsena!",
                                              );
                                              return;
                                            }
                                            if (rez.stateMachine == "Ponistena"){
                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.error,
                                                title: "Greška",
                                                text: "Rezervacija je ponistena!",
                                              );
                                              return;
                                            }
                                            if (rez.stateMachine != "Odobrena"){
                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.error,
                                                title: "Greška",
                                                text: "Rezervacija nije odobrena!",
                                              );
                                              return;
                                            } else {
                                              makePayment(rez);
                                            }
                                          },
                                          child: const Text('Plati'),
                                        ),
                                      ],
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
  Future<void> kreirajUplatu() async {

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
      final cijena = predstava.cijena!.toStringAsFixed(2); // npr. "10.00"

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
                  "total": cijena,
                  "currency": "USD",
                  "details": {
                    "subtotal": cijena,
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
                      "price": cijena,
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
                'Iznos': cijena,
                'korisnikId': AuthProvider.korisnikId,
                'transakcijaId' : data['id'],
                'nacinPlacanja': placanje['payment_method'],
                'status': data['state'],
              };
              await uplataProvider.insert(request);
              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: "Uspješno plaćanje!",
                text: "Uplata je uspjesno izvršena!",
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