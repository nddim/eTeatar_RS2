import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/hrana.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/providers/hrana_provider.dart';
import 'package:eteatar_desktop/screens/hrana_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eteatar_desktop/providers/utils.dart';

class HranaListScreen extends StatefulWidget {
  const HranaListScreen({super.key});

  @override
  State<HranaListScreen> createState() => _HranaListScreenState();
}

class _HranaListScreenState extends State<HranaListScreen> {
  bool _isInit = true;
  bool _isLoading = true;
  late HranaProvider _hranaProvider;
  SearchResult<Hrana>? result = null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _hranaProvider = context.read<HranaProvider>();
      _loadData();
      _isInit = false;
    }
  }

  Future<void> _loadData() async {
    var data = await _hranaProvider.get();
    setState(() {
      result = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista hrane",
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
        var data = await _hranaProvider.get(filter: filter);
        setState(() {
          result = data;
        });

        }, child: Text("Pretraga")),

        SizedBox(width: 10,),
        ElevatedButton(onPressed: () async{
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HranaDetailsScreen()));
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
          DataColumn(label: Text("Cijena")),
        ],
          rows: result?.resultList.map((e) => 
          DataRow(
            onSelectChanged: (selected) => {
              if(selected == true){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HranaDetailsScreen(hrana: e,)))
              }
            },
            cells: [
            DataCell(Text(e.hranaId.toString())),
            DataCell(Text(e.naziv ?? "")),
            DataCell(Text(formatNumber(e.cijena)) ),
          ])).toList().cast<DataRow>() ?? [],
          ),
      )
      )
    );
  }

}