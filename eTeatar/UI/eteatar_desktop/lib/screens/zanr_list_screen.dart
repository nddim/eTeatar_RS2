import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/zanr.dart';
import 'package:eteatar_desktop/providers/zanr_provider.dart';
import 'package:eteatar_desktop/screens/zanr_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class ZanrListScreen extends StatefulWidget {
  const ZanrListScreen({super.key});

  @override
  State<ZanrListScreen> createState() => _ZanrListScreenState();
}

class _ZanrListScreenState extends State<ZanrListScreen> {
  late ZanrProvider _zanrProvider;
  late ZanrDataSource _dataSource;
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
    _zanrProvider = context.read<ZanrProvider>();
    _dataSource = ZanrDataSource(provider: _zanrProvider, context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista zanrova",
      Column(
        children: [
          _buildSearch(),
          _isLoading ? const Text("Nema podataka") : _buildPaginatedTable()
        ],
      ),
    );
  }

  TextEditingController _nazivEditingController = TextEditingController();
  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _nazivEditingController,
              decoration: const InputDecoration(labelText: "Naziv", hintText: "Naziv dvorane"),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _dataSource.filterServerSide(_nazivEditingController.text);
            },
            child: const Text("Pretraga"),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ZanrDetailsScreen()),
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

class ZanrDataSource extends AdvancedDataTableSource<Zanr> {
  List<Zanr> data = [];
  final ZanrProvider provider;
  BuildContext context;
  int count = 10;
  int page = 1;
  int pageSize = 10;
  String nazivGTE = "";
  dynamic filter;
  ZanrDataSource({required this.provider, required this.context});

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final e = data[index];

    return DataRow(cells: [
      DataCell(Text(e.naziv ?? "")),
      DataCell(
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.lightBlue),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ZanrDetailsScreen(zanr: e),
              ),
            );
          },
        ),
      ),
      DataCell(
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _showDeleteDialog(e.zanrId!),
        ),
      ),
    ]);
  }

  void _showDeleteDialog(int zanrId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Brisanje'),
          content: const Text('Da li ste sigurni da želite da obrišete dvoranu?'),
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
                  await provider.delete(zanrId);
                  filterServerSide(nazivGTE);
                } catch (e) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri brisanju dvorane!",
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
  Future<RemoteDataSourceDetails<Zanr>> getNextPage(NextPageRequest request) async {
    final page = (request.offset ~/ pageSize).toInt() + 1;

    final filter = {
      'NazivGTE': nazivGTE,
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

  void filterServerSide(String naziv) {
    nazivGTE = naziv;
    setNextView();
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}