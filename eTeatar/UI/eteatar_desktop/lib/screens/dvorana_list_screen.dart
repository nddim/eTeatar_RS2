import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/dvorana.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/providers/dvorana_provider.dart';
import 'package:eteatar_desktop/screens/dvorana_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:eteatar_desktop/providers/utils.dart';
import 'package:provider/provider.dart';

class DvoranaListScreen extends StatefulWidget {
  const DvoranaListScreen({super.key});

  @override
  State<DvoranaListScreen> createState() => _DvoranaListScreenState();
}

class _DvoranaListScreenState extends State<DvoranaListScreen> {
  late DvoranaProvider _dvoranaProvider;
  SearchResult<Dvorana>? result = null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dvoranaProvider = context.read<DvoranaProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista dvorana", 
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
        var data = await _dvoranaProvider.get(filter: filter);
        setState(() {
          result = data;
        });

        }, child: Text("Pretraga")),
        SizedBox(width: 10,),
        ElevatedButton(onPressed: () async{
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DvoranaDetailsScreen()));
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
          DataColumn(label: Text("Kapacitet")),
        ],
          rows: result?.resultList.map((e) => 
          DataRow(
            onSelectChanged: (selected) => {
              if(selected == true){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DvoranaDetailsScreen(dvorana: e,)))
              }
            },
            cells: [
            DataCell(Text(e.dvoranaId.toString())),
            DataCell(Text(e.naziv ?? "")),
            DataCell(Text(formatNumber(e.kapacitet))),
          ])).toList().cast<DataRow>() ?? [],
          ),
      )
      )
    );
  }
}