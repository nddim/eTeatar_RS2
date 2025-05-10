import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/korisnik.dart';
import 'package:eteatar_desktop/models/rezervacija.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/termin.dart';
import 'package:eteatar_desktop/providers/korisnik_provider.dart';
import 'package:eteatar_desktop/providers/rezervacija_provider.dart';
import 'package:eteatar_desktop/providers/termin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class RezervacijaListScreen extends StatefulWidget {
  const RezervacijaListScreen({super.key});

  @override
  State<RezervacijaListScreen> createState() => _RezervacijaListScreenState();
}

class _RezervacijaListScreenState extends State<RezervacijaListScreen> {
  bool _isInit = true;
  bool _isLoading = true;
  late RezervacijaProvider _rezervacijaProvider;
  late KorisnikProvider _korisnikProvider;
  late TerminProvider _terminProvider;
  SearchResult<Rezervacija>? result = null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    if (_isInit) {
      _rezervacijaProvider = context.read<RezervacijaProvider>();
      _korisnikProvider = context.read<KorisnikProvider>();
      _terminProvider = context.read<TerminProvider>();
      _loadData();
      _isInit = false;
    }
  }

  Future<void> _loadData() async {
    var data;
    try {
      data = await _rezervacijaProvider.get(filter: { 'isDeleted': false});
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju rezervacija!",
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
      "Lista rezervacija",
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

  TextEditingController _nazivEditingController = TextEditingController();

  Widget _buildSearch(){
    return Padding(padding: const EdgeInsets.all(8.0),
    child: Row(
      children:[
        Expanded( child: TextField(controller: _nazivEditingController, decoration: InputDecoration(labelText: "Naziv"))),
        ElevatedButton(onPressed: () async{
        
        var filter = {
          "NazivGTE": _nazivEditingController.text,
          'isDeleted': false
        };
        var data;
        try {
          data = await _rezervacijaProvider.get(filter: filter);
        } catch (e) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "Greška pri dohvatanju rezervacija!",
            width: 300
          );
        }
        setState(() {
          result = data;
        });

        }, child: Text("Pretraga")),
        
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
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Vrijeme termina")),
          DataColumn(label: Text("Korisnik")),
          DataColumn(label: Text('Odobri')),
          DataColumn(label: Text('Ponisti')),
          DataColumn(label: Text('Obriši')),
        ],
          rows: result?.resultList.map((e) => 
          DataRow(
            cells: [
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
            DataCell(
              IconButton(
                icon: const Icon(Icons.check_circle, color: Colors.green ),
                onPressed: () {
                  openOdobriModal(e.rezervacijaId!);
                },
              )
            ),
            DataCell(
              IconButton(
                icon: const Icon(Icons.cancel, color: Colors.orange),
                onPressed: () {
                  openPonistiModal(e.rezervacijaId!);
                },
              )
            ),
            DataCell(
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  openDeleteModal(e.rezervacijaId!);
                },
              )
            ),
          ])).toList().cast<DataRow>() ?? [],
          ),
      )
      )
    );
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

  void openDeleteModal(int rezervacijaId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Brisanje'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da želite da obrišete rezervaciju?'),
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
                  await _rezervacijaProvider.delete(rezervacijaId);
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
                      title: "Greška pri brisanju rezervacije!",
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
                  await _rezervacijaProvider.odobri(rezervacijaId);
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
                      title: "Greška pri odobravanju rezervacije!",
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
                  await _rezervacijaProvider.ponisti(rezervacijaId);
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
                      title: "Greška pri poništavanju rezervacije!",
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
}