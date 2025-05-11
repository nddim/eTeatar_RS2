import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/korisnik.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/uplata.dart';
import 'package:eteatar_desktop/providers/korisnik_provider.dart';
import 'package:eteatar_desktop/providers/uplata_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class UplataListScreen extends StatefulWidget {
  const UplataListScreen({super.key});

  @override
  State<UplataListScreen> createState() => _UplataListScreenState();
}

class _UplataListScreenState extends State<UplataListScreen> {
  late UplataProvider _uplataProvider;
  late UplataDataSource _dataSource;
  late KorisnikProvider _korisnikProvider;
  SearchResult<Korisnik>? _korisnikResult;

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
    _uplataProvider = context.read<UplataProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    _loadData();
    _dataSource = UplataDataSource(provider: _uplataProvider, context: context);
    setState(() {});
  }

  Future<void> _loadData() async {
    var data;
    try {
      data = await _korisnikProvider.get(filter: { 'isDeleted': false});
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju uplata!",
        width: 300
      );
    }
    setState(() {
      _korisnikResult = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista dvorana",
      Column(
        children: [
          _buildSearch(),
          _isLoading ? const Center(child: CircularProgressIndicator()) : _buildPaginatedTable()
        ],
      ),
    );
  }
  TextEditingController _iznosEditingController = TextEditingController();
  int? _selectedKorisnikId;
  
  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded( 
          child: 
          TextField(
            controller: _iznosEditingController, 
            decoration: InputDecoration(labelText: "Iznos")
          )
        ),
        SizedBox(width: 10,),
        Expanded(
          child: FormBuilderDropdown<int>(
            name: "korisnikId",
            decoration: InputDecoration(labelText: "Korisnik"),
            items: _korisnikResult?.resultList
                .map((e) => DropdownMenuItem(
                      value: e.korisnikId,
                      child: Text("${e.ime ?? ""} ${e.prezime ?? ""}"),
                    ))
                .toList() ?? [],
            onChanged: (value) {
              setState(() {
                _selectedKorisnikId = value;
              });
            },
          ),
        ),
        SizedBox(width: 20,),
          ElevatedButton(
            onPressed: () {
              _dataSource.filterServerSide(_iznosEditingController.text, _selectedKorisnikId);
            },
            child: const Text("Pretraga"),
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
                    child: const Text("Transakcija Id"),
                  )),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Nacin placanja"),
                  )),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Status"),
                  )),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Iznos"),
                  )),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Datum"),
                  )),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Korisnik"),
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

class UplataDataSource extends AdvancedDataTableSource<Uplata> {
  List<Uplata> data = [];
  final UplataProvider provider;
  late KorisnikProvider _korisnikProvider;
  BuildContext context;
  int count = 10;
  int page = 1;
  int pageSize = 10;
  String iznosEQ = "";
  int _korisnikIdEQ = 0;
  dynamic filter;
  UplataDataSource({required this.provider, required this.context}){
    _korisnikProvider = context.read<KorisnikProvider>();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final e = data[index];

    return DataRow(cells: [
      DataCell(Text(e.transakcijaId.toString())),
      DataCell(Text(e.nacinPlacanja ?? "")),
      DataCell(Text(e.status ?? "")),
      DataCell(Text(e.iznos.toString())),
      DataCell(Text(e.datum.toString())),
      DataCell(
        FutureBuilder(
          future: fetchKorisnikSafe(e.korisnikId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Učitavanje...");
            } else if (snapshot.hasError) {
              return Text("Greška");
            } else {
              var korisnik = snapshot.data!;
              return Text("${korisnik.ime} ${korisnik.prezime}");
            }
          },
        )
      ),
      DataCell(
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _showDeleteDialog(e.uplataId!),
        ),
      ),
    ]);
  }

  Future<Korisnik> fetchKorisnikSafe(int korisnikId) async {
    try {
      var korisnik = await _korisnikProvider.getById(korisnikId);
      return korisnik;
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška prilikom dohvata korisnika!",
        width: 300
      );
      throw Exception("Greška prilikom dohvata korisnika!");
    }
  }

  void _showDeleteDialog(int uplataId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Brisanje'),
          content: const Text('Da li ste sigurni da želite da obrišete uplatu?'),
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
                  await provider.delete(uplataId);
                  filterServerSide(iznosEQ, _korisnikIdEQ);
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
  Future<RemoteDataSourceDetails<Uplata>> getNextPage(NextPageRequest request) async {
    final page = (request.offset ~/ pageSize).toInt() + 1;

    final filter = {
      'Iznos': iznosEQ,
      if (_korisnikIdEQ > 0) 'KorisnikId': _korisnikIdEQ.toString(),
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

  void filterServerSide(String iznos, int? korisnikId) {
    iznosEQ = iznos;
    _korisnikIdEQ = korisnikId ?? 0;
    setNextView();
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}
