import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/ocjena.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/providers/ocjena_provider.dart';
import 'package:eteatar_desktop/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OcjenaListScreen extends StatefulWidget {
  const OcjenaListScreen({super.key});

  @override
  State<OcjenaListScreen> createState() => _OcjenaListScreenState();
}

class _OcjenaListScreenState extends State<OcjenaListScreen> {

  late OcjenaProvider _ocjenaProvider;
  SearchResult<Ocjena>? result = null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _ocjenaProvider = context.read<OcjenaProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista ocjena", 
    Container(
      child: Column(
        children: [
          _buildSearch(),
          _buildResultView(),
        ],
      )
    )); 
  }

  TextEditingController _vrijednostEditingController = TextEditingController();

  Widget _buildSearch(){
    return Padding(padding: const EdgeInsets.all(8.0),
    child: Row(
      children:[
        Expanded( child: TextField(controller: _vrijednostEditingController, decoration: InputDecoration(labelText: "Vrijednost"))),
        ElevatedButton(onPressed: () async{
        
        var filter = {
          "VrijednostGTE": _vrijednostEditingController.text
        };
        var data = await _ocjenaProvider.get(filter: filter);
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
          DataColumn(label: Text("Vrijednost")),
          DataColumn(label: Text("Komentar")),
          DataColumn(label: Text("Predstava")),
        ],
          rows: result?.resultList.map((e) => 
          DataRow(
            cells: [
            DataCell(Text(e.ocjenaId.toString())),
            DataCell(Text(e.vrijednost.toString())),
            DataCell(Text(e.komentar ?? "")),
            DataCell(Text(e.predstavaId.toString())),

          ])).toList().cast<DataRow>() ?? [],
          ),
      )
      )
    );
  }

}