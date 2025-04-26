import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/korisnik.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/providers/korisnik_provider.dart';
import 'package:eteatar_desktop/screens/korisnik_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eteatar_desktop/providers/utils.dart';
import 'package:quickalert/quickalert.dart';

class KorisnikListScreen extends StatefulWidget {
  const KorisnikListScreen({super.key});

  @override
  State<KorisnikListScreen> createState() => _KorisnikListScreenState();
}

class _KorisnikListScreenState extends State<KorisnikListScreen> {
  bool _isInit = true;
  bool _isLoading = true;
  late KorisnikProvider _korisnikProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _korisnikProvider = context.read<KorisnikProvider>();
      _loadData();
      _isInit = false;
    }
  }

  Future<void> _loadData() async {
    var data; 
    try {
      data = await _korisnikProvider.get(filter: { 'isDeleted': false});
    } catch (e){
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju korisnika!",
        width: 300
      );
    }
    setState(() {
      result = data;
      _isLoading = false;
    });
  }

  SearchResult<Korisnik>? result = null;

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista korisnika",
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

  TextEditingController _imeEditingController = TextEditingController();
  TextEditingController _prezimeEditingController = TextEditingController();
  TextEditingController _korisnickoImeEditingController = TextEditingController();  
  Widget _buildSearch(){
    return Padding(padding: const EdgeInsets.all(8.0),
    child: Row(
      children:[
        Expanded( child: TextField(controller: _imeEditingController, decoration: InputDecoration(labelText: "Ime"))),
        SizedBox(width: 10,),
        Expanded( child: TextField(controller: _prezimeEditingController, decoration: InputDecoration(labelText: "Prezime"))),
        SizedBox(width: 10,),
        Expanded( child: TextField(controller: _korisnickoImeEditingController, decoration: InputDecoration(labelText: "Korisnicko ime"))),
        SizedBox(width: 10,),
        ElevatedButton(onPressed: () async{
        
        var filter = {
          "ImeGTE": _imeEditingController.text,
          "PrezimeGTE": _prezimeEditingController.text,
          "KorisnickoImeGTE": _korisnickoImeEditingController.text,
          'isDeleted': false
        };
        var data;
        try {
          data = await _korisnikProvider.get(filter: filter);
        } catch (e) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "Greška pri dohvatanju korisnika!",
            width: 300
          );
        }
        setState(() {
          result = data;
        });
        }, child: Text("Pretraga")),
        SizedBox(width: 10,),
        ElevatedButton(onPressed: () async{
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => KorisnikDetailsScreen()));
        }, child: Text("Dodaj"))
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
          DataColumn(label: Text("Ime i prezime")),
          DataColumn(label: Text("Prezime")),
          DataColumn(label: Text("Email")),
          DataColumn(label: Text("Telefon")),
          DataColumn(label: Text("Korisnicko ime")),
          DataColumn(label: Text("Slika")),
          DataColumn(label: Text('Uredi')),
          DataColumn(label: Text('Obriši')),

        ],
          rows: result?.resultList.map((e) => 
          DataRow(
            cells: [
            DataCell(Text(e.ime ?? "")),
            DataCell(Text(e.prezime ?? "")),
            DataCell(Text(e.email ?? "")),
            DataCell(Text(e.telefon ?? "")),
            DataCell(Text(e.korisnickoIme ?? "")),
            DataCell(
              e.slika != null 
              ? Container(width: 100, height: 100, child: imageFromString(e.slika!),) : Text("")),
            DataCell(
              IconButton(
                icon: Icon(Icons.edit,
                    color: Theme.of(context).primaryColor),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => KorisnikDetailsScreen(korisnik: e,)));
                },
              )
            ),
            DataCell(
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  openDeleteModal(e.korisnikId!);
                },
              )
            ),
          ])).toList().cast<DataRow>() ?? [],
          ),
      )
      )
    );
  }

  void openDeleteModal(int korisnikId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Brisanje'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da želite da obrišete korisnika?'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text(
                'Poništi',
                style: TextStyle(color: Color.fromRGBO(72, 142, 255, 1)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _korisnikProvider.delete(korisnikId);
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
                      title: "Greška pri brisanju korisnika!",
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

}