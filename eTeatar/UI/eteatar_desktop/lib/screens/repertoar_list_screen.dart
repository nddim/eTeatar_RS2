import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/repertoar.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/providers/repertoar_provider.dart';
import 'package:eteatar_desktop/screens/repertoar_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RepertoarListScreen extends StatefulWidget {
  const RepertoarListScreen({super.key});

  @override
  State<RepertoarListScreen> createState() => _RepertoarListScreenState();
}

class _RepertoarListScreenState extends State<RepertoarListScreen> {
  bool _isInit = true;
  bool _isLoading = true;
  late RepertoarProvider _repertoarProvider;
  SearchResult<Repertoar>? result = null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _repertoarProvider = context.read<RepertoarProvider>();
      _loadData();
      _isInit = false;
    }
  }

  Future<void> _loadData() async {
    var data = await _repertoarProvider.get();
    setState(() {
      result = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista repertoara",
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
        var data = await _repertoarProvider.get(filter: filter);
        setState(() {
          result = data;
        });

        }, child: Text("Pretraga")),

        SizedBox(width: 10,),
        ElevatedButton(onPressed: () async{
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => RepertoarDetailsScreen()));
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
          DataColumn(label: Text("Datum Pocetka")),
          DataColumn(label: Text("Datum Kraja")),

        ],
          rows: result?.resultList.map((e) => 
          DataRow(
            onSelectChanged: (selected) => {
              if(selected == true){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RepertoarDetailsScreen(repertoar: e,)))
              }
            },
            cells: [
            DataCell(Text(e.repertoarId.toString())),
            DataCell(Text(e.naziv ?? "")),
            DataCell(Text(e.datumPocetka.toString())),
            DataCell(Text(e.datumKraja.toString())),
          ])).toList().cast<DataRow>() ?? [],
          ),
      )
      )
    );
  }
}