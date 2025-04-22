import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/korisnik.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/uplata.dart';
import 'package:eteatar_desktop/providers/korisnik_provider.dart';
import 'package:eteatar_desktop/providers/uplata_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class UplataListScreen extends StatefulWidget {
  const UplataListScreen({super.key});

  @override
  State<UplataListScreen> createState() => _UplataListScreenState();
}

class _UplataListScreenState extends State<UplataListScreen> {
  bool _isInit = true;
  bool _isLoading = true;
  late UplataProvider _uplataProvider;
  late KorisnikProvider _korisnikProvider;
  SearchResult<Uplata>? result = null;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _uplataProvider = context.read<UplataProvider>();
      _korisnikProvider = context.read<KorisnikProvider>();
      _loadData();
      _isInit = false;
    }
  }

  Future<void> _loadData() async {
    var data;
    try {
      data = await _uplataProvider.get();
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju uplata!",
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
      "Lista uplata",
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

  TextEditingController _iznosEditingController = TextEditingController();

  Widget _buildSearch(){
    return Padding(padding: const EdgeInsets.all(8.0),
    child: Row(
      children:[
        Expanded( child: TextField(controller: _iznosEditingController, decoration: InputDecoration(labelText: "Naziv"))),
        ElevatedButton(onPressed: () async{
        
        var filter = {
          "IznosGTE": _iznosEditingController.text
        };
        var data;
        try {
          data = await _uplataProvider.get(filter: filter);
        } catch (e) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "Greška pri dohvatanju uplata!",
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
          DataColumn(label: Text("Iznos")),
          DataColumn(label: Text("Datum")),
          DataColumn(label: Text("Korisnik")),

        ],
          rows: result?.resultList.map((e) => 
          DataRow(
            cells: [
            DataCell(Text(e.uplataId.toString())),
            DataCell(Text(e.iznos.toString())),
            DataCell(Text(e.datum.toString())),
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
}