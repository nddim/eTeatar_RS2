import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/korisnik.dart';
import 'package:eteatar_desktop/models/rezervacija.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/termin.dart';
import 'package:eteatar_desktop/providers/korisnik_provider.dart';
import 'package:eteatar_desktop/providers/rezervacija_provider.dart';
import 'package:eteatar_desktop/providers/termin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class RezervacijaListScreen extends StatefulWidget {
  const RezervacijaListScreen({super.key});

  @override
  State<RezervacijaListScreen> createState() => _RezervacijaListScreenState();
}

class _RezervacijaListScreenState extends State<RezervacijaListScreen> {
  late RezervacijaProvider _rezervacijaProvider;
  late KorisnikProvider _korisnikProvider;
  late RezervacijaDataSource _dataSource;
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
    _rezervacijaProvider = context.read<RezervacijaProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    _loadData();
    _dataSource = RezervacijaDataSource(provider: _rezervacijaProvider, context: context);
    setState(() {});
  }

  Future<void> _loadData() async {
    try {
      var result = await _korisnikProvider.get(filter: { 'isDeleted': false});
      setState(() {
        _korisnikResult = result;
      });
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju korisnika!",
        text: "$e",
        width: 300
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista rezervacija",
      Column(
        children: [
          _buildSearch(),
          _isLoading ? const Text("Nema podataka") : _buildPaginatedTable()
        ],
      ),
    );
  }

  final Map<int, String> _statusMap = {
    1: "Kreirano",
    2: "Odobreno",
    3: "Ponisteno",
    4: "Zavrseno",
  };

  Key _dropdownKey = UniqueKey();
  Key _statusDropdownKey = UniqueKey();
  int? _selectedKorisnikId;
  int? _selectedStatus;
  
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
          const SizedBox(width: 20,),
          ElevatedButton(
            onPressed: () {
              _dataSource.filterServerSide( _statusMap[_selectedStatus] ?? "", _selectedKorisnikId);
            },
            child: const Text("Pretraga"),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedKorisnikId = null;
                _selectedStatus = null;
                _dropdownKey = UniqueKey();
                _statusDropdownKey = UniqueKey();
              });
              _dataSource.filterServerSide("", null);
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
                    child: const Text("Status"),
                  )),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Vrijeme termina"),
                  )),
                                    DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Korisnik"),
                  )),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Akcije"),
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

class RezervacijaDataSource extends AdvancedDataTableSource<Rezervacija> {
  List<Rezervacija> data = [];
  final RezervacijaProvider provider;
  late KorisnikProvider _korisnikProvider;
  late TerminProvider _terminProvider;
  BuildContext context;
  int count = 10;
  int page = 1;
  int pageSize = 10;
  String statusEQ = "";
  int korisnikIdEQ = 0;
  dynamic filter;
  final Map<String, List<String>> dozvoljeneAkcije = {
  'Kreirano': ['odobri', 'ponisti', 'obrisi'],
  'Odobreno': ['ponisti', 'obrisi'],
  'Ponisteno': ['obrisi'],
  'Zavrseno': ['obrisi']
};

  RezervacijaDataSource({required this.provider, required this.context}){
    _korisnikProvider = context.read<KorisnikProvider>();
    _terminProvider = context.read<TerminProvider>();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final e = data[index];
    final akcije = dozvoljeneAkcije[e.stateMachine ?? ""] ?? [];
    return DataRow(cells: [
      DataCell(Text(e.stateMachine ?? "")),
      DataCell(
        FutureBuilder(
          future: fetchTermin(e.terminId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Učitavanje...");
            } else if (snapshot.hasError) {
              return Text("Greška");
            } else {
              var termin = snapshot.data!;
              return Text("${termin.datum}");
            }
          },
        )
      ),
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
     DataCell(Row(
      children: [
        if (akcije.contains('odobri'))
          IconButton(
            icon: const Icon(Icons.check_circle, color: Colors.green),
            tooltip: "Odobri",
            onPressed: () => openOdobriModal(e.rezervacijaId!),
          ),
        if (akcije.contains('ponisti'))
          IconButton(
            icon: const Icon(Icons.cancel, color: Colors.orange),
            tooltip: "Poništi",
            onPressed: () => openPonistiModal(e.rezervacijaId!),
          ),
        if (akcije.contains('obrisi'))
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            tooltip: "Obriši",
            onPressed: () => _showDeleteDialog(e.rezervacijaId!),
          ),
      ],
    ))
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
  Future<Termin> fetchTermin(int terminId) async {
    try {
      var termin = await _terminProvider.getById(terminId);
      return termin;
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška prilikom dohvata termina!",
        text: "$e",
        width: 300
      );
      throw Exception("Greška prilikom dohvata termina!");
    }
  }

  void _showDeleteDialog(int dvoranaId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Brisanje'),
          content: const Text('Da li ste sigurni da želite da obrišete rezervaciju?'),
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
                  filterServerSide(statusEQ, korisnikIdEQ);
                } catch (e) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri brisanju rezervacije!",
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

  void openOdobriModal(int rezervacijaId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Odobravanje'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da želite da odobrite rezervaciju?'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text(
                'Poništi akciju',
                style: TextStyle(color: Color.fromRGBO(72, 142, 255, 1)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await provider.odobri(rezervacijaId);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                  filterServerSide(statusEQ, korisnikIdEQ);
                } catch (e) {
                  if (context.mounted) {
                    Navigator.pop(context);
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: "Greška pri odobravanju rezervacije!",
                      text: "$e",
                      width: 300
                    );
                  }
                }
              },
              child: const Text(
                'Odobri',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  void openPonistiModal(int rezervacijaId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Poništavanje'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da želite da poništite rezervaciju?'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text(
                'Poništi akciju',
                style: TextStyle(color: Color.fromRGBO(72, 142, 255, 1)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await provider.ponisti(rezervacijaId);
                  await QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: "Uspješno poništena rezervacija!",
                  width: 300);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                  filterServerSide(statusEQ, korisnikIdEQ);
                } catch (e) {
                  if (context.mounted) {
                    Navigator.pop(context);
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: "Greška pri poništavanju rezervacije!",
                      text: "$e",
                      width: 300
                    );
                  }
                }
              },
              child: const Text(
                'Poništi',
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Future<RemoteDataSourceDetails<Rezervacija>> getNextPage(NextPageRequest request) async {
    final page = (request.offset ~/ pageSize).toInt() + 1;

    final filter = {
      'Status': statusEQ,
      if (korisnikIdEQ > 0) 'KorisnikId': korisnikIdEQ.toString(),
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

  void filterServerSide(String status, int? korisnikId) {
    statusEQ = status;
    korisnikIdEQ = korisnikId ?? 0;
    setNextView();
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}
