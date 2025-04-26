import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/karta.dart';
import 'package:eteatar_desktop/models/korisnik.dart';
import 'package:eteatar_desktop/models/rezervacija.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/sjediste.dart';
import 'package:eteatar_desktop/models/termin.dart';
import 'package:eteatar_desktop/providers/karta_provider.dart';
import 'package:eteatar_desktop/providers/korisnik_provider.dart';
import 'package:eteatar_desktop/providers/rezervacija_provider.dart';
import 'package:eteatar_desktop/providers/sjediste_provider.dart';
import 'package:eteatar_desktop/providers/termin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eteatar_desktop/providers/utils.dart';
import 'package:quickalert/quickalert.dart';

class KartaListScreen extends StatefulWidget {
  const KartaListScreen({super.key});

  @override
  State<KartaListScreen> createState() => _KartaListScreenState();
}

class _KartaListScreenState extends State<KartaListScreen> {
  bool _isInit = true;
  bool _isLoading = true;
  late KartaProvider _kartaProvider;
  late KorisnikProvider _korisnikProvider;
  late TerminProvider _terminProvider;
  late RezervacijaProvider _rezervacijaProvider;
  late SjedisteProvider _sjedisteProvider;
  SearchResult<Karta>? result = null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _kartaProvider = context.read<KartaProvider>();
      _korisnikProvider = context.read<KorisnikProvider>();
      _terminProvider = context.read<TerminProvider>();
      _rezervacijaProvider = context.read<RezervacijaProvider>();
      _sjedisteProvider = context.read<SjedisteProvider>();
      _loadData();
      _isInit = false;
    }
  }

  Future<void> _loadData() async {
    var data;
    try {
      data = await _kartaProvider.get(filter: { 'isDeleted': false});
    } catch (e){
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju karte!",
        width: 300
      );
    }
    setState(() {
      result = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista karata",
      _isLoading 
      ? Center(child: CircularProgressIndicator())
      : Column(
          children: [
            _buildSearch(),
            _buildResultView(),
          ],
        ),
    );
  }

  TextEditingController _korisnikEditingController = TextEditingController();

  Widget _buildSearch(){
    return Padding(padding: const EdgeInsets.all(8.0),
    child: Row(
      children:[
        Expanded( child: TextField(controller: _korisnikEditingController, decoration: const InputDecoration(labelText: "Korisnik Id", hintText: "Korisnik Id karte"))),
        ElevatedButton(onPressed: () async{
        
        var filter = {
          "KorisnikId": _korisnikEditingController.text,
          'isDeleted': false
        };
        var data;
        try {
          data = await _kartaProvider.get(filter: filter);
        } catch (e) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "Greška pri dohvatanju karte!",
            width: 300
          );
        }
        setState(() {
          result = data;
        });

        }, child: Text("Pretraga")),
        ],
      ),
    );
  }

  Widget _buildResultView(){
    return Expanded(
      child: Container(
        width: double.infinity,
        child: SingleChildScrollView(
        child: DataTable(
        columns: const [
          DataColumn(label: Text("Cijena")),
          DataColumn(label: Text("Naziv sjedista"), numeric:true),
          DataColumn(label: Text("Datum termina"), numeric:true),
          DataColumn(label: Text("Status rezervacije"), numeric:true),
          DataColumn(label: Text("Korisnik"), numeric:true),
          DataColumn(label: Text('Obriši')),
        ],
          rows: result?.resultList.map((e) => 
          DataRow(
            cells: [
            DataCell(Text(formatNumber(e.cijena))),
            DataCell(
              FutureBuilder(
                future: fetchSjediste(e.sjedisteId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Učitavanje...");
                  } else if (snapshot.hasError) {
                    return Text("Greška");
                  } else {
                    var sjediste = snapshot.data!;
                    return Text("${sjediste.red} x ${sjediste.kolona}");
                  }
                },
              )
            ),
            DataCell(
              FutureBuilder(
                future: fetchTermin(e.terminId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Učitavanje...");
                  } else if (snapshot.hasError) {
                    return Text("Greška");
                  } else {
                    var termin = snapshot.data!;
                    return Text("${formatDateTime(termin.datum!.toString())}");
                  }
                },
              )
            ),
            DataCell(
              e.rezervacijaId == null ? Text("Ne postoji") :
              FutureBuilder(
                future: fetchRezervacija(e.rezervacijaId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Učitavanje...");
                  } else if (snapshot.hasError) {
                    return Text("Greška");
                  } else {
                    var rezervacija = snapshot.data!;
                    return Text("${rezervacija.status}");
                  }
                },
              )
            ),
            DataCell(
              FutureBuilder(
                future: fetchKorisnikSafe(e.korisnikId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Učitavanje...");
                  } else if (snapshot.hasError) {
                    return Text("Greška");
                  } else {
                    var korisnik = snapshot.data!;
                    return Text("${korisnik.ime} ${korisnik.prezime}");
                  }
                },
              )
            ),
  
            DataCell(
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  openDeleteModal(e.kartaId!);
                },
              )
            ),
          ])).toList().cast<DataRow>() ?? [],
          ),
      )
      )
    );
  }

  Future<Korisnik> fetchKorisnikSafe(int korisnikId) async {
    try {
      var korisnik = await _korisnikProvider.getById(korisnikId);
      return korisnik;
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška prilikom dohvata korisnika!",
        width: 300
      );
      throw Exception("Greška prilikom dohvata korisnika!");
    }
  }

  Future<Termin> fetchTermin(int terminId) async {
    try {
      var termin = await _terminProvider.getById(terminId);
      return termin;
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška prilikom dohvata termina!",
        width: 300
      );
      throw Exception("Greška prilikom dohvata termina!");
    }
  }

  Future<Rezervacija> fetchRezervacija(int rezervacijaId) async {
    try {
      var rezervacija = await _rezervacijaProvider.getById(rezervacijaId);
      return rezervacija;
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška prilikom dohvata rezervacija!",
        width: 300
      );
      throw Exception("Greška prilikom dohvata rezervacija!");
    }
  }

  Future<Sjediste> fetchSjediste(int rezervacijaId) async {
    try {
      var sjediste = await _sjedisteProvider.getById(rezervacijaId);
      return sjediste;
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška prilikom dohvata sjedista!",
        width: 300
      );
      throw Exception("Greška prilikom dohvata sjedista!");
    }
  }

  void openDeleteModal(int karataId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Brisanje'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da želite da obrišete kartu?'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text(
                'Poništi',
                style: TextStyle(color: Color.fromRGBO(72, 142, 255, 1)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _kartaProvider.delete(karataId);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                  await _loadData();
                } catch (e) {
                  if (context.mounted) {
                    Navigator.pop(context);
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: "Greška pri brisanju karte!",
                      width: 300
                    );
                  }
                }
              },
              child: const Text(
                'Obriši',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

}