import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/korisnik.dart';
import 'package:eteatar_desktop/models/rezervacija.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/termin.dart';
import 'package:eteatar_desktop/providers/korisnik_provider.dart';
import 'package:eteatar_desktop/providers/rezervacija_provider.dart';
import 'package:eteatar_desktop/providers/termin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class RezervacijaListScreen extends StatefulWidget {
  const RezervacijaListScreen({super.key});

  @override
  State<RezervacijaListScreen> createState() => _RezervacijaListScreenState();
}

class _RezervacijaListScreenState extends State<RezervacijaListScreen> {
  bool _isInit = true;
  bool _isLoading = true;
  late RezervacijaProvider _rezervacijaProvider;
  late KorisnikProvider _korisnikProvider;
  late TerminProvider _terminProvider;
  SearchResult<Rezervacija>? result = null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    if (_isInit) {
      _rezervacijaProvider = context.read<RezervacijaProvider>();
      _korisnikProvider = context.read<KorisnikProvider>();
      _terminProvider = context.read<TerminProvider>();
      _loadData();
      _isInit = false;
    }
  }

  Future<void> _loadData() async {
    var data;
    try {
      data = await _rezervacijaProvider.get();
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju rezervacija!",
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
      "Lista rezervacija",
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

  TextEditingController _nazivEditingController = TextEditingController();

  Widget _buildSearch(){
    return Padding(padding: const EdgeInsets.all(8.0),
    child: Row(
      children:[
        Expanded( child: TextField(controller: _nazivEditingController, decoration: InputDecoration(labelText: "Naziv"))),
        ElevatedButton(onPressed: () async{
        
        var filter = {
          "NazivGTE": _nazivEditingController.text
        };
        var data;
        try {
          data = await _rezervacijaProvider.get(filter: filter);
        } catch (e) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "Greška pri dohvatanju rezervacija!",
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
          DataColumn(label: Text("Id"), numeric:true),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Vrijeme termina")),
          DataColumn(label: Text("Korisnik")),
        ],
          rows: result?.resultList.map((e) => 
          DataRow(
            cells: [
            DataCell(Text(e.rezervacijaId.toString())),
            DataCell(Text(e.status ?? "")),
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
                    return Text("${termin.datum}");
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
}