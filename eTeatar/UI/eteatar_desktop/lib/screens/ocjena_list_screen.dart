import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/ocjena.dart';
import 'package:eteatar_desktop/models/predstava.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/providers/ocjena_provider.dart';
import 'package:eteatar_desktop/providers/predstava_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
  SearchResult<Predstava>? predstavaResult = null;
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
      data = await _ocjenaProvider.get(filter: { 'isDeleted': false});
    } catch (e){
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju ocjena!",
        width: 300
      );
    }
    try {
      predstavaResult = await _predstavaProvider.get(filter: { 'isDeleted': false});
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

  int? _selectedVrijednost;
  int? _selectedPredstavaId;

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<int>(
              value: _selectedVrijednost,
              decoration: const InputDecoration(labelText: "Vrijednost"),
              items: const[
                DropdownMenuItem(value: 1, child: Text("1")),
                DropdownMenuItem(value: 2, child: Text("2")),
                DropdownMenuItem(value: 3, child: Text("3")),
                DropdownMenuItem(value: 4, child: Text("4")),
                DropdownMenuItem(value: 5, child: Text("5")),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedVrijednost = value;
                });
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
          child: FormBuilderDropdown<int>(
            name: "predstavaId",
            decoration: InputDecoration(labelText: "Predstava"),
            items: predstavaResult?.resultList
                .map((e) => DropdownMenuItem(
                      value: e.predstavaId,
                      child: Text(e.naziv ?? ""),
                    ))
                .toList() ?? [],
            onChanged: (value) {
              setState(() {
                _selectedPredstavaId = value;
              });
            },
          ),
        ),
        const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () async {
              var filter = {
                if (_selectedVrijednost != null)
                  "VrijednostGTE": _selectedVrijednost.toString(),
                  "PredstavaId": _selectedPredstavaId,
                  'isDeleted': false,
              };
              var data;
              try {
                data = await _ocjenaProvider.get(filter: filter);
              } catch (e) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: "Greška pri dohvatanju ocjena!",
                  width: 300,
                );
              }
              setState(() {
                result = data;
              });
            },
            child: const Text("Pretraga"),
          ),
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
          DataColumn(label: Text("Vrijednost")),
          DataColumn(label: Text("Komentar")),
          DataColumn(label: Text("Predstava")),
          DataColumn(label: Text('Obriši')),
        ],
          rows: result?.resultList.map((e) => 
          DataRow(
            cells: [
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
            DataCell(
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  openDeleteModal(e.ocjenaId!);
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

  void openDeleteModal(int ocjenaId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Brisanje'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da želite da obrišete ocjenu?'),
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
                  await _ocjenaProvider.delete(ocjenaId);
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
                      title: "Greška pri brisanju ocjene!",
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