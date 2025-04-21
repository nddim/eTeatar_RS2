import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/rezervacija.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/providers/korisnik_provider.dart';
import 'package:eteatar_desktop/providers/rezervacija_provider.dart';
import 'package:eteatar_desktop/providers/termin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RezervacijaListScreen extends StatefulWidget {
  const RezervacijaListScreen({super.key});

  @override
  State<RezervacijaListScreen> createState() => _RezervacijaListScreenState();
}

class _RezervacijaListScreenState extends State<RezervacijaListScreen> {
  late RezervacijaProvider _rezervacijaProvider;
  late KorisnikProvider _korisnikProvider;
  late TerminProvider _terminProvider;
  SearchResult<Rezervacija>? result = null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _rezervacijaProvider = context.read<RezervacijaProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    _terminProvider = context.read<TerminProvider>();

  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista rezervacija", 
    Container(
      child: Column(
        children: [
          _buildSearch(),
          _buildResultView(),
        ],
      )
    )); 
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
        var data = await _rezervacijaProvider.get(filter: filter);
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
                future: _terminProvider.getById(e.terminId!),
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
                future: _korisnikProvider.getById(e.korisnikId!),
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

}