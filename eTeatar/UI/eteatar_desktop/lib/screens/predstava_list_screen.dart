import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/predstava.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/zanr.dart';
import 'package:eteatar_desktop/providers/predstava_provider.dart';
import 'package:eteatar_desktop/providers/utils.dart';
import 'package:eteatar_desktop/providers/zanr_provider.dart';
import 'package:eteatar_desktop/screens/predstava_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
  late ZanrProvider _zanrProvider;
  SearchResult<Zanr>? _zanrResult;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _predstavaProvider = context.read<PredstavaProvider>();
      _zanrProvider = context.read<ZanrProvider>();
      _loadData();
      _isInit = false;
    }
  }

  Future<void> _loadData() async {
    var data;
    try {
      data = await _predstavaProvider.get(filter: { 'isDeleted': false});
    } catch (e){
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju predstava!",
        width: 300
      );
    }
    try {
      _zanrResult = await _zanrProvider.get(filter: { 'isDeleted': false});
    } catch (e){
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju zanrova!",
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
  int? _selectedZanrId;

  Widget _buildSearch(){
    return Padding(padding: const EdgeInsets.all(8.0),
    child: Row(
      children:[
        Expanded( child: TextField(controller: _nazivEditingController, decoration: InputDecoration(labelText: "Naziv"))),
        SizedBox(width: 20,),
        Expanded(
          child: FormBuilderDropdown<int>(
            name: "zanrId",
            decoration: InputDecoration(labelText: "Žanr"),
            items: _zanrResult?.resultList
                .map((e) => DropdownMenuItem(
                      value: e.zanrId,
                      child: Text(e.naziv ?? ""),
                    ))
                .toList() ?? [],
            onChanged: (value) {
              setState(() {
                _selectedZanrId = value;
              });
            },
          ),
        ),
        SizedBox(width: 20,),
        ElevatedButton(onPressed: () async{
        
        var filter = {
          "NazivGTE": _nazivEditingController.text,
          "ZanrId": _selectedZanrId,
          'isDeleted': false
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
          DataColumn(label: Text("Naziv")),
          DataColumn(label: Text("Cijena")),
          DataColumn(label: Text("Slika")),
          DataColumn(label: Text('Uredi')),
          DataColumn(label: Text('Obriši')),
        ],
          rows: result?.resultList.map((e) => 
          DataRow(
            cells: [
            DataCell(Text(e.naziv ?? "")),
            DataCell(Text(e.cijena.toString())),
            DataCell(e.slika != null ? Container(width: 100, height: 100, child: imageFromString(e.slika!),): Text("")),
            DataCell(
              IconButton(
                icon: Icon(Icons.edit,
                    color: Theme.of(context).primaryColor),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PredstavaDetailsScreen(predstava: e,)));
                },
              )
            ),
            DataCell(
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  openDeleteModal(e.predstavaId!);
                },
              )
            ),
          ])).toList().cast<DataRow>() ?? [],
          ),
      )
      )
    );
  }

  void openDeleteModal(int predstavaId){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Brisanje'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da želite da obrišete predstavu?'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text(
                'Poništi',
                style: TextStyle(color: Color.fromRGBO(72, 142, 255, 1)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _predstavaProvider.delete(predstavaId);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                  await _loadData();
                } catch (e) {
                  if (context.mounted) {
                    Navigator.pop(context);
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: "Greška pri brisanju predstave!",
                      width: 300
                    );
                  }
                }
              },
              child: const Text(
                'Obriši',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

}