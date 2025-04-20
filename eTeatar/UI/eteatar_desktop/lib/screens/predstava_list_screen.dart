import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/predstava.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/providers/predstava_provider.dart';
import 'package:eteatar_desktop/providers/utils.dart';
import 'package:eteatar_desktop/screens/predstava_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PredstavaListScreen extends StatefulWidget {
  const PredstavaListScreen({super.key});

  @override
  State<PredstavaListScreen> createState() => _PredstavaListScreenState();
}

class _PredstavaListScreenState extends State<PredstavaListScreen> {

  late PredstavaProvider _predstavaProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _predstavaProvider = context.read<PredstavaProvider>();
  }

  SearchResult<Predstava>? result = null;

  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista predstava", 
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
        var data = await _predstavaProvider.get(filter: filter);
        setState(() {
          result = data;
        });

        }, child: Text("Pretraga")),

        SizedBox(width: 10,),
        ElevatedButton(onPressed: () async{
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PredstavaDetailsScreen()));
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
        columns: [
          DataColumn(label: Text("Id"), numeric:true),
          DataColumn(label: Text("Naziv")),
          DataColumn(label: Text("Cijena")),
          DataColumn(label: Text("Slika")),
        ],
          rows: result?.resultList.map((e) => 
          DataRow(
            onSelectChanged: (selected) => {
              if(selected == true){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PredstavaDetailsScreen(predstava: e,)))
              }
            },
            cells: [
            DataCell(Text(e.predstavaId.toString())),
            DataCell(Text(e.naziv ?? "")),
            DataCell(Text(formatNumber(e.cijena))),
            DataCell(e.slika != null ? Container(width: 100, height: 100, child: imageFromString(e.slika!),): Text(""))
          ])).toList().cast<DataRow>() ?? [],
          ),
      )
      )
    );
  }
}