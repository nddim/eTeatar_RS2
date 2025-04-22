import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/dvorana.dart';
import 'package:eteatar_desktop/models/predstava.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/termin.dart';
import 'package:eteatar_desktop/providers/dvorana_provider.dart';
import 'package:eteatar_desktop/providers/predstava_provider.dart';
import 'package:eteatar_desktop/providers/termin_provider.dart';
import 'package:eteatar_desktop/screens/termin_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class TerminListScreen extends StatefulWidget {
  const TerminListScreen({super.key});

  @override
  State<TerminListScreen> createState() => _TerminListScreenState();
}

class _TerminListScreenState extends State<TerminListScreen> {
  bool _isInit = true;
  bool _isLoading = true;
  late TerminProvider _terminProvider;
  late DvoranaProvider _dvoranaProvider;
  late PredstavaProvider _predstavaProvider;
  SearchResult<Termin>? result = null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _terminProvider = context.read<TerminProvider>();
      _dvoranaProvider = context.read<DvoranaProvider>();
      _predstavaProvider = context.read<PredstavaProvider>();
      _loadData();
      _isInit = false;
    }
  }

  Future<void> _loadData() async {
    var data;
    try {
      data = await _terminProvider.get();
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju termina!",
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
      "Lista termina",
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
        var data;
        try {
          data = await _terminProvider.get(filter: filter);
        } catch (e) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "Greška pri dohvatanju termina!",
            width: 300
          );
        }
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
            DataCell(Text(e.datum.toString())),
            DataCell(
              FutureBuilder(
                future: fetchDvorana(e.dvoranaId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Učitavanje...");
                  } else if (snapshot.hasError) {
                    return Text("Greška");
                  } else {
                    var dvorana = snapshot.data!;
                    return Text("${dvorana.naziv}");
                  }
                },
              )
            ),
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

  Future<Dvorana> fetchDvorana(int dvoranaId) async {
    try {
      var dvorana = await _dvoranaProvider.getById(dvoranaId);
      return dvorana;
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška prilikom dohvata dvorane!",
        width: 300
      );
      throw Exception("Greška prilikom dohvata dvorane!");
    }
  }
  Future<Predstava> fetchPredstava(int predstavaId) async {
    try {
      var dvorana = await _predstavaProvider.getById(predstavaId);
      return dvorana;
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška prilikom dohvata predstave!",
        width: 300
      );
      throw Exception("Greška prilikom dohvata predstave!");
    }
  }
}