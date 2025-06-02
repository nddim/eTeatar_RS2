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
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:eteatar_desktop/providers/utils.dart';

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
  final _formKey = GlobalKey<FormBuilderState>();

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
        text: "$e",
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
      "Lista uplata",
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
  Key _dropdownKey = UniqueKey();

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilder(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                name: "iznos",
                controller: _iznosEditingController,
                decoration: const InputDecoration(
                  labelText: "Iznos",
                  hintText: "Unesite iznos u KM",
                ),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(errorText: "Unos mora biti broj"),
                  FormBuilderValidators.min(1, errorText: "Iznos ne može biti manji od 1 KM"),
                  FormBuilderValidators.max(100000, errorText: "Iznos ne može biti veći od 100000 KM"),
                ]),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: 
              DropdownButtonFormField<int>(
                key: _dropdownKey,
                value: _selectedKorisnikId,
                decoration: const InputDecoration(labelText: "Korisnik"),
                items: _korisnikResult?.resultList.map((e) => DropdownMenuItem(
                  value: e.korisnikId,
                  child: Text("${e.ime ?? ""} ${e.prezime ?? ""}"),
                )).toList() ?? [],
                onChanged: (value) {
                  setState(() {
                    _selectedKorisnikId = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
            onPressed: () {
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                  _dataSource.filterServerSide(
                    _iznosEditingController.text,
                    _selectedKorisnikId,
                  );
                }
              },
            child: const Text("Pretraga"),
          ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                _iznosEditingController.clear();
                setState(() {
                  _selectedKorisnikId = null;
                  _dropdownKey = UniqueKey();
                });
                _dataSource.filterServerSide("", null);
              },
              child: const Text("Resetuj filtere"),
            ),
          ],
        ),
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
      DataCell(Text("${formatCurrency(e.iznos)} KM")),
      DataCell(Text(formatDateTime(e.datum.toString()))),
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
        text: "$e",
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
                  await QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: "Uspješno obrisana uplata!",
                  width: 300);
                  filterServerSide(iznosEQ, _korisnikIdEQ);
                } catch (e) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri brisanju dvorane!",
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
        text: "$e",
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
