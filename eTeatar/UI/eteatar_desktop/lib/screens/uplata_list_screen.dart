import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/uplata.dart';
import 'package:eteatar_desktop/providers/korisnik_provider.dart';
import 'package:eteatar_desktop/providers/uplata_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UplataListScreen extends StatefulWidget {
  const UplataListScreen({super.key});

  @override
  State<UplataListScreen> createState() => _UplataListScreenState();
}

class _UplataListScreenState extends State<UplataListScreen> {

  late UplataProvider _uplataProvider;
  late KorisnikProvider _korisnikProvider;
  SearchResult<Uplata>? result = null;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _uplataProvider = context.read<UplataProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista uplata", 
    Container(
      child: Column(
        children: [
          _buildSearch(),
          _buildResultView(),
        ],
      )
    )); 
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
        var data = await _uplataProvider.get(filter: filter);
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