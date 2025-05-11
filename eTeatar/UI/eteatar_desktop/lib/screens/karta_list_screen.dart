import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/karta.dart';
import 'package:eteatar_desktop/models/korisnik.dart';
import 'package:eteatar_desktop/models/sjediste.dart';
import 'package:eteatar_desktop/models/termin.dart';
import 'package:eteatar_desktop/providers/karta_provider.dart';
import 'package:eteatar_desktop/providers/korisnik_provider.dart';
import 'package:eteatar_desktop/providers/sjediste_provider.dart';
import 'package:eteatar_desktop/providers/termin_provider.dart';
import 'package:eteatar_desktop/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class KartaListScreen extends StatefulWidget {
  const KartaListScreen({super.key});

  @override
  State<KartaListScreen> createState() => _KartaListScreenState();
}

class _KartaListScreenState extends State<KartaListScreen> {
  late KartaProvider _kartaProvider;
  late KartaDataSource _dataSource;
  bool _isLoading = false;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _kartaProvider = context.read<KartaProvider>();
    _dataSource = KartaDataSource(provider: _kartaProvider, context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista karata",
      Column(
        children: [
          _buildSearch(),
          _isLoading ? const Text("Nema podataka") : _buildPaginatedTable()
        ],
      ),
    );
  }

  TextEditingController _korisnikEditingController = TextEditingController();
   Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _korisnikEditingController,
              decoration: const InputDecoration(labelText: "Ime korisnika", hintText: "Ime korisnika"),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _dataSource.filterServerSide(_korisnikEditingController.text);
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
                    child: const Text("Cijena"),
                  )),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Naziv sjedista"),
                  ), numeric:true),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Datum termina"),
                  ), numeric:true),
                  DataColumn(
                      label: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Korisnik"),
                  ), numeric:true),
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

class KartaDataSource extends AdvancedDataTableSource<Karta> {
  List<Karta> data = [];
  final KartaProvider provider;
  late KorisnikProvider _korisnikProvider;
  late TerminProvider _terminProvider;
  late SjedisteProvider _sjedisteProvider;
  BuildContext context;
  int count = 10;
  int page = 1;
  int pageSize = 10;
  String imeGTE = "";
  dynamic filter;
  KartaDataSource({required this.provider, required this.context}) {
  _korisnikProvider = context.read<KorisnikProvider>();
  _terminProvider = context.read<TerminProvider>();
  _sjedisteProvider = context.read<SjedisteProvider>();
}

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final e = data[index];

    return DataRow(cells: [
      DataCell(Text(e.cijena.toString())),
      DataCell(
        FutureBuilder(
          future: fetchSjediste(e.sjedisteId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Učitavanje...");
            } else if (snapshot.hasError) {
              return Text("Greška");
            } else {
              var sjediste = snapshot.data!;
              return Text("${sjediste.red} x ${sjediste.kolona}");
            }
          },
        )
      ),
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
              return Text("${formatDateTime(termin.datum!.toString())}");
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
      DataCell(
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _showDeleteDialog(e.kartaId!),
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

  Future<Termin> fetchTermin(int terminId) async {
    try {
      var termin = await _terminProvider.getById(terminId);
      return termin;
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška prilikom dohvata termina!",
        width: 300
      );
      throw Exception("Greška prilikom dohvata termina!");
    }
  }

  Future<Sjediste> fetchSjediste(int rezervacijaId) async {
    try {
      var sjediste = await _sjedisteProvider.getById(rezervacijaId);
      return sjediste;
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška prilikom dohvata sjedista!",
        width: 300
      );
      throw Exception("Greška prilikom dohvata sjedista!");
    }
  }

  void _showDeleteDialog(int kartaId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Brisanje'),
          content: const Text('Da li ste sigurni da želite da obrišete kartu?'),
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
                  await provider.delete(kartaId);
                  filterServerSide(imeGTE);
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
  Future<RemoteDataSourceDetails<Karta>> getNextPage(NextPageRequest request) async {
    final page = (request.offset ~/ pageSize).toInt() + 1;

    final filter = {
      'ImeGTE': imeGTE,
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
    imeGTE = naziv;
    setNextView();
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}
