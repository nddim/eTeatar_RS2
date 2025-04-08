import 'package:eteatar_desktop/screens/korisnik_list_screen.dart';
import 'package:eteatar_desktop/screens/predstava_list_screen.dart';
import 'package:flutter/material.dart';

class MasterScreen extends StatefulWidget {
  MasterScreen(this.title, this.child, {super.key});
  String title;
  Widget child;
  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      drawer: Drawer(
        child: ListView(
          children: [
             ListTile(
              title: Text("Nazad"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Predstave"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PredstavaListScreen()));
              },
            ),
            ListTile(
              title: Text("Korisnici"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => KorisnikListScreen()));
              },
            ),
          ],
        ),
      ),
      body: widget.child,
    );
  }
}