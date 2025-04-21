import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/korisnik.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/providers/korisnik_provider.dart';
import 'package:eteatar_desktop/screens/korisnik_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eteatar_desktop/providers/utils.dart';

class KorisnikListScreen extends StatefulWidget {
  const KorisnikListScreen({super.key});

  @override
  State<KorisnikListScreen> createState() => _KorisnikListScreenState();
}

class _KorisnikListScreenState extends State<KorisnikListScreen> {

  late KorisnikProvider _korisnikProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _korisnikProvider = context.read<KorisnikProvider>();
  }
  SearchResult<Korisnik>? result = null;

  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista korisnika", 
    Container(
      child: Column(
        children: [
          _buildSearch(),
          _buildResultView(),
        ],
      )
    )); 
  }

  TextEditingController _imeEditingController = TextEditingController();

  Widget _buildSearch(){
    return Padding(padding: const EdgeInsets.all(8.0),
    child: Row(
      children:[
        Expanded( child: TextField(controller: _imeEditingController, decoration: InputDecoration(labelText: "Ime"))),
        ElevatedButton(onPressed: () async{
        
        var filter = {
          "ImeGTE": _imeEditingController.text
        };
        var data = await _korisnikProvider.get(filter: filter);
        setState(() {
          result = data;
        });

        }, child: Text("Pretraga")),

        SizedBox(width: 10,),
        ElevatedButton(onPressed: () async{
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => KorisnikDetailsScreen()));
        }, child: Text("Dodaj"))
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
          DataColumn(label: Text("Ime")),
          DataColumn(label: Text("Prezime")),
          DataColumn(label: Text("Email")),
          DataColumn(label: Text("Telefon")),
          DataColumn(label: Text("Korisnicko ime")),
          DataColumn(label: Text("Slika")),

        ],
          rows: result?.resultList.map((e) => 
          DataRow(
            onSelectChanged: (selected) => {
              if(selected == true){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => KorisnikDetailsScreen(korisnik: e,)))
              }
            },
            cells: [
            DataCell(Text(e.korisnikId.toString())),
            DataCell(Text(e.ime ?? "")),
            DataCell(Text(e.prezime ?? "")),
            DataCell(Text(e.email ?? "")),
            DataCell(Text(e.telefon ?? "")),
            DataCell(Text(e.korisnickoIme ?? "")),
            DataCell(e.slika != null ? Container(width: 100, height: 100, child: imageFromString(e.slika!),): Text(""))
          ])).toList().cast<DataRow>() ?? [],
          ),
      )
      )
    );
  }
}