import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/stavka_uplate.dart';
import 'package:eteatar_desktop/providers/stavka_uplate_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StavkaUplateListScreen extends StatefulWidget {
  const StavkaUplateListScreen({super.key});

  @override
  State<StavkaUplateListScreen> createState() => _StavkaUplateListScreenState();
}

class _StavkaUplateListScreenState extends State<StavkaUplateListScreen> {
  bool _isInit = true;
  bool _isLoading = true;
  late StavkaUplateProvider _stavkaUplateProvider;
  SearchResult<StavkaUplate>? result = null;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _stavkaUplateProvider = context.read<StavkaUplateProvider>();
      _loadData();
      _isInit = false;
    }
  }

  Future<void> _loadData() async {
    var data = await _stavkaUplateProvider.get();
    setState(() {
      result = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista stavki uplata",
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

  TextEditingController _cijenaEditingController = TextEditingController();

  Widget _buildSearch(){
    return Padding(padding: const EdgeInsets.all(8.0),
    child: Row(
      children:[
        Expanded( child: TextField(controller: _cijenaEditingController, decoration: InputDecoration(labelText: "Cijena"))),
        ElevatedButton(onPressed: () async{
        
        var filter = {
          "NazivGTE": _cijenaEditingController.text
        };
        var data = await _stavkaUplateProvider.get(filter: filter);
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
          DataColumn(label: Text("Kolicina")),
          DataColumn(label: Text("Cijena")),
        ],
          rows: result?.resultList.map((e) => 
          DataRow(
            cells: [
            DataCell(Text(e.stavkaUplateId.toString())),
            DataCell(Text(e.kolicina.toString())),
            DataCell(Text(e.cijena.toString())),
          ])).toList().cast<DataRow>() ?? [],
          ),
      )
      )
    );
  }

}