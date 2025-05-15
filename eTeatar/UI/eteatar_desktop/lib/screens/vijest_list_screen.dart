import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/korisnik.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/vijest.dart';
import 'package:eteatar_desktop/providers/korisnik_provider.dart';
import 'package:eteatar_desktop/providers/vijest_provider.dart';
import 'package:eteatar_desktop/screens/vijest_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class VijestListScreen extends StatefulWidget {
  const VijestListScreen({super.key});

  @override
  State<VijestListScreen> createState() => _VijestListScreenState();
}

class _VijestListScreenState extends State<VijestListScreen> {
  late VijestProvider _vijestProvider;
  late KorisnikProvider _korisnikProvider;
  late VijestDataSource _dataSource;
  bool _isLoading = false;
  SearchResult<Korisnik>? _korisnikResult;

  @override
  BuildContext get context => super.context;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _vijestProvider = context.read<VijestProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    _loadData();
    _dataSource = VijestDataSource(provider: _vijestProvider, context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista vijesti",
      Column(
        children: [
          _buildSearch(),
          _isLoading ? const Text("Nema podataka") : _buildPaginatedTable()
        ],
      ),
    );
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
        text: "$e",
        width: 300
      );
    }
    setState(() {
      _korisnikResult = data;
    });
  }

  TextEditingController _nazivEditingController = TextEditingController();
  int? _selectedKorisnikId;
  Key _dropdownKey = UniqueKey();

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
          SizedBox(width: 20,),
          Expanded(
            child: FormBuilderDropdown<int>(
              key: _dropdownKey,
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
              _dataSource.filterServerSide(_nazivEditingController.text, _selectedKorisnikId);
            },
            child: const Text("Pretraga"),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _nazivEditingController.clear();
                _selectedKorisnikId = null;
                _dropdownKey = UniqueKey();
              });
              _dataSource.filterServerSide("", null);
            },
            child: const Text("Resetuj filtere"),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const VijestDetailsScreen()),
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

class VijestDataSource extends AdvancedDataTableSource<Vijest> {
  List<Vijest> data = [];
  final VijestProvider provider;
  late KorisnikProvider _korisnikProvider;
  BuildContext context;
  int count = 10;
  int page = 1;
  int pageSize = 10;
  String nazivGTE = "";
  int _korisnikIdEQ = 0;
  dynamic filter;
  VijestDataSource({required this.provider, required this.context}){
    _korisnikProvider = context.read<KorisnikProvider>();
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
        text: "$e",
        width: 300
      );
      throw Exception("Greška prilikom dohvata korisnika!");
    }
  }

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final e = data[index];

    return DataRow(cells: [
      DataCell(Text(e.naziv ?? "")),
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
          icon: const Icon(Icons.edit, color: Colors.lightBlue),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => VijestDetailsScreen(vijest: e),
              ),
            );
          },
        ),
      ),
      DataCell(
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _showDeleteDialog(e.vijestId!),
        ),
      ),
    ]);
  }
  
  void _showDeleteDialog(int vijestId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Brisanje'),
          content: const Text('Da li ste sigurni da želite da obrišete vijest?'),
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
                  await provider.delete(vijestId);
                  await QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: "Uspješno obrisana vijest!",
                  width: 300);
                  filterServerSide(nazivGTE, _korisnikIdEQ);
                } catch (e) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri brisanju vijesti!",
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
  Future<RemoteDataSourceDetails<Vijest>> getNextPage(NextPageRequest request) async {
    final page = (request.offset ~/ pageSize).toInt() + 1;

    final filter = {
      'NazivGTE': nazivGTE,
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
        text: "$e",
      );
      return RemoteDataSourceDetails(0, []);
    }
  }

  void filterServerSide(String naziv, int? korisnikId) {
    nazivGTE = naziv;
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
