import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/ocjena.dart';
import 'package:eteatar_desktop/models/predstava.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/providers/ocjena_provider.dart';
import 'package:eteatar_desktop/providers/predstava_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class OcjenaListScreen extends StatefulWidget {
  const OcjenaListScreen({super.key});

  @override
  State<OcjenaListScreen> createState() => _OcjenaListScreenState();
}

class _OcjenaListScreenState extends State<OcjenaListScreen> {
  bool _isInit = true;
  bool _isLoading = true;
  late OcjenaProvider _ocjenaProvider;
  late PredstavaProvider _predstavaProvider;
  SearchResult<Ocjena>? result = null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _ocjenaProvider = context.read<OcjenaProvider>();
      _predstavaProvider = context.read<PredstavaProvider>();
      _loadData();
      _isInit = false;
    }
  }

  Future<void> _loadData() async {
    var data ;
    try {
      data = await _ocjenaProvider.get();
    } catch (e){
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju ocjena!",
        width: 300
      );
    }
    setState(() {
      result = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista ocjena",
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
        var data;
        try {
          data = await _ocjenaProvider.get(filter: filter);
        } catch (e) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "Greška pri dohvatanju ocjena!",
            width: 300
          );
        }
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
            DataCell(
              FutureBuilder(
                future: fetchPredstava(e.predstavaId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Učitavanje...");
                  } else if (snapshot.hasError) {
                    return Text("Greška");
                  } else {
                    var predstava = snapshot.data!;
                    return Text("${predstava.naziv}");
                  }
                },
              )
            ),
          ])).toList().cast<DataRow>() ?? [],
          ),
      )
      )
    );
  }
  Future<Predstava> fetchPredstava(int predstavaId) async {
    try {
      var predstava = await _predstavaProvider.getById(predstavaId);
      return predstava;
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška prilikom dohvatanja predstava!",
        width: 300
      );
      throw Exception("Greška prilikom dohvatanja predstava!");
    }
  }
}