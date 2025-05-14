import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
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
  late OcjenaProvider _ocjenaProvider;
  late OcjenaDataSource _dataSource;
  late PredstavaProvider _predstavaProvider;
  bool _isLoading = false;
  SearchResult<Predstava>? predstavaResult;

  @override
  BuildContext get context => super.context;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _loadPredstave() async {
    try {
      var result = await _predstavaProvider.get(filter: { 'isDeleted': false});
      setState(() {
      predstavaResult = result;
    });
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatu predstava!",
        text: "$e",
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _ocjenaProvider = context.read<OcjenaProvider>();
    _predstavaProvider = context.read<PredstavaProvider>();
    _loadPredstave();
    _dataSource = OcjenaDataSource(provider: _ocjenaProvider, context: context);
    setState(() {});
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
            _isLoading ? const Text("Nema podataka") : _buildPaginatedTable()
          ],
        ),
    );
  }

  int? _selectedVrijednost;
  int? _selectedPredstavaId;
  Key _vrijednostdropdownKey = UniqueKey();
  Key _predstavadropdownKey = UniqueKey();
  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
            Expanded(
              child: DropdownButtonFormField<int>(
                key: _vrijednostdropdownKey,
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
              key: _predstavadropdownKey,
              name: "predstavaId",
              decoration: InputDecoration(labelText: "Predstava"),
              items: predstavaResult?.resultList
                  .map((e) => DropdownMenuItem(
                        value: e.predstavaId,
                        child: Text(e.naziv ?? "")
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
            onPressed: () {
              _dataSource.filterServerSide(_selectedVrijednost, _selectedPredstavaId);
            },
            child: const Text("Pretraga"),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedPredstavaId = null;
                _selectedVrijednost = null;
                _vrijednostdropdownKey = UniqueKey();
                _predstavadropdownKey = UniqueKey();
              });
              _dataSource.filterServerSide(null, null);
            },
            child: const Text("Resetuj filtere"),
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
                    child: const Text("Vrijednost"),
                  )),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Komentar"),
                  )),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Predstava"),
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

class OcjenaDataSource extends AdvancedDataTableSource<Ocjena> {
  List<Ocjena> data = [];
  late PredstavaProvider _predstavaProvider;
  final OcjenaProvider provider;
  BuildContext context;
  int count = 10;
  int page = 1;
  int pageSize = 10;
  int vrijednostGTE = 0;
  int predstavaIdEQ = 0;
  dynamic filter;
  OcjenaDataSource({required this.provider, required this.context}){
    _predstavaProvider = context.read<PredstavaProvider>();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final e = data[index];

    return DataRow(cells: [
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
          onPressed: () => _showDeleteDialog(e.ocjenaId!),
        ),
      ),
    ]);
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
        text: "$e",
        width: 300
      );
      throw Exception("Greška prilikom dohvatanja predstava!");
    }
  }
  void _showDeleteDialog(int dvoranaId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Brisanje'),
          content: const Text('Da li ste sigurni da želite da obrišete ocjenu?'),
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
                  filterServerSide(vrijednostGTE, predstavaIdEQ);
                } catch (e) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri brisanju ocjene!",
                    text: "$e",
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
  Future<RemoteDataSourceDetails<Ocjena>> getNextPage(NextPageRequest request) async {
    final page = (request.offset ~/ pageSize).toInt() + 1;

    final filter = {
      'isDeleted': false,
      if (vrijednostGTE > 0) 'VrijednostGTE': vrijednostGTE.toString(),
      if (predstavaIdEQ > 0) 'PredstavaId': predstavaIdEQ.toString(),
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
        text: "$e",
      );
      return RemoteDataSourceDetails(0, []);
    }
  }

  void filterServerSide(int? vrijednost, int? predstavaId) {
    vrijednostGTE = vrijednost ?? 0;
    predstavaIdEQ = predstavaId ?? 0;
    setNextView();
}

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}
