import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/predstava.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/providers/predstava_provider.dart';
import 'package:eteatar_desktop/providers/utils.dart';
import 'package:eteatar_desktop/screens/predstava_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class PredstavaListScreen extends StatefulWidget {
  const PredstavaListScreen({super.key});

  @override
  State<PredstavaListScreen> createState() => _PredstavaListScreenState();
}

class _PredstavaListScreenState extends State<PredstavaListScreen> {
  bool _isInit = true;
  bool _isLoading = true;
  late PredstavaProvider _predstavaProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _predstavaProvider = context.read<PredstavaProvider>();
      _loadData();
      _isInit = false;
    }
  }

  Future<void> _loadData() async {
    var data;
    try {
      data = await _predstavaProvider.get();
    } catch (e){
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju predstava!",
        width: 300
      );
    }
    setState(() {
      result = data;
      _isLoading = false;
    });
  }

  SearchResult<Predstava>? result = null;

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista predstava",
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
        var data;
        try {
          data = await _predstavaProvider.get(filter: filter);
        } catch (e) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "Greška pri dohvatanju preddstava!",
            width: 300
          );
        }
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
        columns: const [
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