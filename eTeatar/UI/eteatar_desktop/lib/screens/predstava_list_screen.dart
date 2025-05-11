import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
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
  late PredstavaProvider _predstavaProvider;
  late PredstavaDataSource _dataSource;
  late ZanrProvider _zanrProvider;
  SearchResult<Zanr>? _zanrResult;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _predstavaProvider = context.read<PredstavaProvider>();
    _zanrProvider = context.read<ZanrProvider>();
    _loadZanr();
    _dataSource = PredstavaDataSource(provider: _predstavaProvider, context: context);
    setState(() {});
  }

  Future<void> _loadZanr() async {
    try {
      var result = await _zanrProvider.get(filter: { 'isDeleted': false});
      setState(() {
        _zanrResult = result;
      });
    } catch (e){
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju zanrova!",
        width: 300
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista predstava",
      Column(
        children: [
          _buildSearch(),
          _isLoading ? const Text("Nema podataka") : _buildPaginatedTable()
        ],
      ),
    );
  }

  TextEditingController _nazivEditingController = TextEditingController();
  int? _selectedZanrId;
  
  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded( 
            child: TextField(
              controller: _nazivEditingController, 
              decoration: InputDecoration(labelText: "Naziv")
            )
          ),
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
          ElevatedButton(
            onPressed: () {
              _dataSource.filterServerSide(_nazivEditingController.text, _selectedZanrId);
            },
            child: const Text("Pretraga"),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PredstavaDetailsScreen()),
              );
            },
            child: const Text("Dodaj"),
          ),
        ],
      ),
    );
  }
  Widget _buildPaginatedTable() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: SizedBox(
              width: double.infinity,
              child: AdvancedPaginatedDataTable(
                columns: [
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Naziv"),
                  )),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Cijena"),
                  )),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Trajanje"),
                  )),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Slika"),
                  )),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Uredi"),
                  )),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Obriši"),
                  )),
                ],
                source: _dataSource,
                addEmptyRows: false,
              )),
        ),
      ),
    );
  }
}

class PredstavaDataSource extends AdvancedDataTableSource<Predstava> {
  List<Predstava> data = [];
  final PredstavaProvider provider;
  BuildContext context;
  int count = 10;
  int page = 1;
  int pageSize = 10;
  String nazivGTE = "";
  int zanrIdEQ = 0;
  dynamic filter;
  PredstavaDataSource({required this.provider, required this.context});

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final e = data[index];

    return DataRow(cells: [
      DataCell(Text(e.naziv ?? "")),
      DataCell(Text("${e.cijena.toString()} KM")),
      DataCell(Text("${e.trajanje.toString()} mins")),
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
          onPressed: () => _showDeleteDialog(e.predstavaId!),
        ),
      ),
    ]);
  }

  void _showDeleteDialog(int dvoranaId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Brisanje'),
          content: const Text('Da li ste sigurni da želite da obrišete predstavu?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Poništi'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);
                try {
                  await provider.delete(dvoranaId);
                  filterServerSide(nazivGTE, zanrIdEQ);
                } catch (e) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri brisanju predstave!",
                  );
                }
              },
              child: const Text('Obriši', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Future<RemoteDataSourceDetails<Predstava>> getNextPage(NextPageRequest request) async {
    final page = (request.offset ~/ pageSize).toInt() + 1;

    final filter = {
      'NazivGTE': nazivGTE,
      if (zanrIdEQ > 0) 'ZanrId': zanrIdEQ.toString(),
      'isDeleted': false
    };

    try {
      final result = await provider.get(
        filter: filter,
        page: page,
        pageSize: pageSize
        );
      data = result.resultList;
      count = result.count;
      notifyListeners();
      return RemoteDataSourceDetails(count, data);
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatu podataka!",
      );
      return RemoteDataSourceDetails(0, []);
    }
  }

  void filterServerSide(String naziv, int? zanrId) {
    nazivGTE = naziv;
    zanrIdEQ = zanrId ?? 0;
    setNextView();
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}
