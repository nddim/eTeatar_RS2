import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/termin.dart';
import 'package:eteatar_desktop/providers/termin_provider.dart';
import 'package:eteatar_desktop/screens/termin_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TerminListScreen extends StatefulWidget {
  const TerminListScreen({super.key});

  @override
  State<TerminListScreen> createState() => _TerminListScreenState();
}

class _TerminListScreenState extends State<TerminListScreen> {

  late TerminProvider _terminProvider;
  SearchResult<Termin>? result = null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _terminProvider = context.read<TerminProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista termina", 
    Container(
      child: Column(
        children: [
          _buildSearch(),
          _buildResultView(),
        ],
      )
    )); 
  }

  TextEditingController _statusEditingController = TextEditingController();

  Widget _buildSearch(){
    return Padding(padding: const EdgeInsets.all(8.0),
    child: Row(
      children:[
        Expanded( child: TextField(controller: _statusEditingController, decoration: InputDecoration(labelText: "Status"))),
        ElevatedButton(onPressed: () async{
        
        var filter = {
          "Status": _statusEditingController.text
        };
        var data = await _terminProvider.get(filter: filter);
        setState(() {
          result = data;
        });
        
        }, child: Text("Pretraga")),
        SizedBox(width: 10,),
        ElevatedButton(onPressed: () async{
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TerminDetailsScreen()));
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
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Datum")),
          DataColumn(label: Text("Dvorana")),
          DataColumn(label: Text("Predstava")),
        ],
          rows: result?.resultList.map((e) => 
          DataRow(
            onSelectChanged: (selected) => {
              if(selected == true){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TerminDetailsScreen(termin: e,)))
              }
            },
            cells: [
            DataCell(Text(e.terminId.toString())),
            DataCell(Text(e.status ?? "")),
            DataCell(Text(e.datum.toString() ?? "")),
            DataCell(Text(e.dvoranaId.toString())),
            DataCell(Text(e.predstavaId.toString())),
          ])).toList().cast<DataRow>() ?? [],
          ),
      )
      )
    );
  }

}