import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/karta.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/providers/karta_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eteatar_desktop/providers/utils.dart';

class KartaListScreen extends StatefulWidget {
  const KartaListScreen({super.key});

  @override
  State<KartaListScreen> createState() => _KartaListScreenState();
}

class _KartaListScreenState extends State<KartaListScreen> {
  late KartaProvider _kartaProvider;
  SearchResult<Karta>? result = null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _kartaProvider = context.read<KartaProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista karata", 
    Container(
      child: Column(
        children: [
          _buildSearch(),
          _buildResultView(),
        ],
      )
    )); 
  }
  TextEditingController _korisnikEditingController = TextEditingController();

  Widget _buildSearch(){
    return Padding(padding: const EdgeInsets.all(8.0),
    child: Row(
      children:[
        Expanded( child: TextField(controller: _korisnikEditingController, decoration: InputDecoration(labelText: "Korisnik Id"))),
        ElevatedButton(onPressed: () async{
        
        var filter = {
          "KorisnikId": _korisnikEditingController.text
        };
        var data = await _kartaProvider.get(filter: filter);
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
          DataColumn(label: Text("Id"), numeric:true),
          DataColumn(label: Text("Cijena")),
          DataColumn(label: Text("Sjediste Id"), numeric:true),
          DataColumn(label: Text("Termin Id"), numeric:true),
          DataColumn(label: Text("Rezervacija Id"), numeric:true),
          DataColumn(label: Text("Korisnik Id"), numeric:true),
        ],
          rows: result?.resultList.map((e) => 
          DataRow(
            cells: [
            DataCell(Text(e.kartaId.toString())),
            DataCell(Text(formatNumber(e.cijena))),
            DataCell(Text(e.sjedisteId.toString())),
            DataCell(Text(e.terminId.toString())),
            DataCell(Text(e.rezervacijaId.toString())),
            DataCell(Text(e.korisnikId.toString())),
          ])).toList().cast<DataRow>() ?? [],
          ),
      )
      )
    );
  }

}