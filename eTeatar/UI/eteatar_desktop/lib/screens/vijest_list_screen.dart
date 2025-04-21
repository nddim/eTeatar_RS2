import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/vijest.dart';
import 'package:eteatar_desktop/providers/vijest_provider.dart';
import 'package:eteatar_desktop/screens/vijest_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VijestListScreen extends StatefulWidget {
  const VijestListScreen({super.key});

  @override
  State<VijestListScreen> createState() => _VijestListScreenState();
}

class _VijestListScreenState extends State<VijestListScreen> {

  late VijestProvider _vijestProvider;
  SearchResult<Vijest>? result = null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _vijestProvider = context.read<VijestProvider>();
  }

  
  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista vijesti", 
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
        var data = await _vijestProvider.get(filter: filter);
        setState(() {
          result = data;
        });

        }, child: Text("Pretraga")),
        SizedBox(width: 10,),
        ElevatedButton(onPressed: () async{
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => VijestDetailsScreen()));
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
          DataColumn(label: Text("Naziv")),
          DataColumn(label: Text("Datum")),
          DataColumn(label: Text("Korisnik")),
        ],
          rows: result?.resultList.map((e) => 
          DataRow(
            onSelectChanged: (selected) => {
              if(selected == true){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => VijestDetailsScreen(vijest: e,)))
              }
            },
            cells: [
            DataCell(Text(e.vijestId.toString())),
            DataCell(Text(e.naziv ?? "")),
            DataCell(Text(e.datum.toString())),
            DataCell(Text(e.korisnikId.toString())),
          ])).toList().cast<DataRow>() ?? [],
          ),
      )
      )
    );
  }

}