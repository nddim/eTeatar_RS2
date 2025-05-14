import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
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
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class TerminListScreen extends StatefulWidget {
  const TerminListScreen({super.key});

  @override
  State<TerminListScreen> createState() => _TerminListScreenState();
}

class _TerminListScreenState extends State<TerminListScreen> {
  late TerminProvider _terminProvider;
  late TerminDataSource _dataSource;
  late DvoranaProvider _dvoranaProvider;
  late PredstavaProvider _predstavaProvider;
  SearchResult<Predstava>? _predstavaResult;
  SearchResult<Dvorana>? _dvoranaResult;

  bool _isLoading = false;
  @override
  BuildContext get context => super.context;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _terminProvider = context.read<TerminProvider>();
    _predstavaProvider = context.read<PredstavaProvider>();
    _dvoranaProvider = context.read<DvoranaProvider>();
    _loadData();
    _dataSource = TerminDataSource(provider: _terminProvider, context: context);
    setState(() {});
  }

  Future<void> _loadData() async {
    var predstavaResult;
    var dvoranaResult;
    try {
      predstavaResult = await _predstavaProvider.get(filter: { 'isDeleted': false});
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju termina!",
        text: "$e",
        width: 300
      );
    }

    try {
      dvoranaResult = await _dvoranaProvider.get(filter: { 'isDeleted': false});
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju termina!",
        text: "$e",
        width: 300
      );
    }
    setState(() {
      _dvoranaResult = dvoranaResult;
      _predstavaResult = predstavaResult;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista termina",
      Column(
        children: [
          _buildSearch(),
          _isLoading ? const Text("Nema podataka") : _buildPaginatedTable()
        ],
      ),
    );
  }
  final Map<int, String> _statusMap = {
    1: "Aktivan",
    2: "Neaktivan",
  };
  Key _statusDropdownKey = UniqueKey();
  Key _dvoranaDropdownKey = UniqueKey();
  Key _predstavadropdownKey = UniqueKey();
  int? _selectedStatus;
  int? _selectedPredstavaId;
  int? _selectedDvoranaId;
  
  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<int>(
              key: _statusDropdownKey,
              value: _selectedStatus,
              decoration: const InputDecoration(labelText: "Status"),
              items: _statusMap.entries
                  .map((entry) => DropdownMenuItem(
                        value: entry.key,
                        child: Text(entry.value),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value;
                });
              },
            ),
          ),
          const SizedBox(width: 20,),
          Expanded(
            child: FormBuilderDropdown<int>(
              key: _predstavadropdownKey,
              name: "predstavaId",
              decoration: InputDecoration(labelText: "Predstava"),
              items: _predstavaResult?.resultList
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
          const SizedBox(width: 20,),
          Expanded(
            child: FormBuilderDropdown<int>(
              key: _dvoranaDropdownKey,
              name: "dvoranaId",
              decoration: InputDecoration(labelText: "Dvorana"),
              items: _dvoranaResult?.resultList
                  .map((e) => DropdownMenuItem(
                        value: e.dvoranaId,
                        child: Text(e.naziv ?? ""),
                      ))
                  .toList() ?? [],
              onChanged: (value) {
                setState(() {
                  _selectedDvoranaId = value;
                });
              },
            ),
          ),
          const SizedBox(width: 20,),
          ElevatedButton(
            onPressed: () {
              _dataSource.filterServerSide(_statusMap[_selectedStatus] ?? "", _selectedPredstavaId, _selectedDvoranaId);
            },
            child: const Text("Pretraga"),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedDvoranaId = null;
                _selectedStatus = null;
                _selectedPredstavaId = null;
                _statusDropdownKey = UniqueKey();
                _dvoranaDropdownKey = UniqueKey();
                _predstavadropdownKey = UniqueKey();
              });
              _dataSource.filterServerSide("", null, null);
            },
            child: const Text("Resetuj filtere"),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const TerminDetailsScreen()),
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
                    child: const Text("Status"),
                  )),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Datum"),
                  )),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Dvorana"),
                  )),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Predstava"),
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

class TerminDataSource extends AdvancedDataTableSource<Termin> {
  List<Termin> data = [];
  final TerminProvider provider;
  late DvoranaProvider _dvoranaProvider;
  late PredstavaProvider _predstavaProvider;
  BuildContext context;
  int count = 10;
  int page = 1;
  int pageSize = 10;
  String status = "";
  int _predstavaIdEQ = 0;
  int _dvoranaIdEQ = 0;
  dynamic filter;
  TerminDataSource({required this.provider, required this.context}){
    _dvoranaProvider = context.read<DvoranaProvider>();
    _predstavaProvider = context.read<PredstavaProvider>();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final e = data[index];

    return DataRow(cells: [
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
      DataCell(
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.lightBlue),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TerminDetailsScreen(termin: e),
              ),
            );
          },
        ),
      ),
      DataCell(
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _showDeleteDialog(e.dvoranaId!),
        ),
      ),
    ]);
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
        text: "$e",
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
        text: "$e",
        width: 300
      );
      throw Exception("Greška prilikom dohvata predstave!");
    }
  }
  void _showDeleteDialog(int terminId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Brisanje'),
          content: const Text('Da li ste sigurni da želite da obrišete termin?'),
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
                  await provider.delete(terminId);
                  filterServerSide(status, _predstavaIdEQ, _dvoranaIdEQ);
                } catch (e) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri brisanju termina!",
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
  Future<RemoteDataSourceDetails<Termin>> getNextPage(NextPageRequest request) async {
    final page = (request.offset ~/ pageSize).toInt() + 1;

    final filter = {
      'Status': status,
      if (_predstavaIdEQ > 0) 'PredstavaId': _predstavaIdEQ.toString(),
      if (_dvoranaIdEQ > 0) 'DvoranaId': _dvoranaIdEQ.toString(),
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
        text: "$e",
      );
      return RemoteDataSourceDetails(0, []);
    }
  }

  void filterServerSide(String status1, int? predstavaId, int? dvoranaId) {
    status = status1;
    _predstavaIdEQ = predstavaId ?? 0;
    _dvoranaIdEQ = dvoranaId ?? 0;
    setNextView();
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}