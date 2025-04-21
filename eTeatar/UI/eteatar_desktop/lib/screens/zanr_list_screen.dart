import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/zanr.dart';
import 'package:eteatar_desktop/providers/zanr_provider.dart';
import 'package:eteatar_desktop/screens/zanr_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZanrListScreen extends StatefulWidget {
  const ZanrListScreen({super.key});

  @override
  State<ZanrListScreen> createState() => _ZanrListScreenState();
}

class _ZanrListScreenState extends State<ZanrListScreen> {
  bool _isInit = true;
  bool _isLoading = true;
  late ZanrProvider _zanrProvider;
  SearchResult<Zanr>? result = null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _zanrProvider = context.read<ZanrProvider>();
      _loadData();
      _isInit = false;
    }
  }

  Future<void> _loadData() async {
    var data = await _zanrProvider.get();
    setState(() {
      result = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista zanrovi",
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
        var data = await _zanrProvider.get(filter: filter);
        setState(() {
          result = data;
        });

        }, child: Text("Pretraga")),
        SizedBox(width: 10,),
        ElevatedButton(onPressed: () async{
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ZanrDetailsScreen()));
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
        ],
          rows: result?.resultList.map((e) => 
          DataRow(
            onSelectChanged: (selected) => {
              if(selected == true){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ZanrDetailsScreen(zanr: e,)))
              }
            },
            cells: [
            DataCell(Text(e.zanrId.toString())),
            DataCell(Text(e.naziv ?? "")),
          ])).toList().cast<DataRow>() ?? [],
          ),
      )
      )
    );
  }

}