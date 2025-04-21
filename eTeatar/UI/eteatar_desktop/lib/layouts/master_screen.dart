import 'package:eteatar_desktop/main.dart';
import 'package:eteatar_desktop/providers/auth_provider.dart';
import 'package:eteatar_desktop/screens/dvorana_list_screen.dart';
import 'package:eteatar_desktop/screens/glumac_list_screen.dart';
import 'package:eteatar_desktop/screens/hrana_list_screen.dart';
import 'package:eteatar_desktop/screens/karta_list_screen.dart';
import 'package:eteatar_desktop/screens/korisnik_list_screen.dart';
import 'package:eteatar_desktop/screens/ocjena_list_screen.dart';
import 'package:eteatar_desktop/screens/predstava_list_screen.dart';
import 'package:eteatar_desktop/screens/repertoar_list_screen.dart';
import 'package:eteatar_desktop/screens/rezervacija_list_screen.dart';
import 'package:eteatar_desktop/screens/stavka_uplate_list_screen.dart';
import 'package:eteatar_desktop/screens/termin_list_screen.dart';
import 'package:eteatar_desktop/screens/uplata_list_screen.dart';
import 'package:eteatar_desktop/screens/vijest_list_screen.dart';
import 'package:eteatar_desktop/screens/zanr_list_screen.dart';
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 72, 142, 255),
        title: Text(widget.title),
        ),
        drawer: _buildDrawer(),
        body: widget.child,
    );
  }
  
  _buildDrawer() {
    return Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(72, 142, 255, 1),
              ),
              accountName: Text(""),
              accountEmail: Text(
                "Administrator",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
              )
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildDrawerItem(
                    icon: Icons.theaters,
                    label: "Dvorane",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => DvoranaListScreen()));
                    }
                  ),
                  _buildDrawerItem(
                    icon: Icons.person_outline,
                    label: "Glumci",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => GlumacListScreen()));
                    }
                  ),
                  _buildDrawerItem(
                    icon: Icons.fastfood,
                    label: "Hrana",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HranaListScreen()));
                    }
                  ),
                  _buildDrawerItem(
                    icon: Icons.confirmation_number_outlined,
                    label: "Karte",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => KartaListScreen()));
                    }
                  ),
                  _buildDrawerItem(
                    icon: Icons.person,
                    label: "Korisnici",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => KorisnikListScreen()));
                    }
                  ),
                  _buildDrawerItem(
                    icon: Icons.star_border,
                    label: "Ocjene",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => OcjenaListScreen()));
                    }
                  ),
                  _buildDrawerItem(
                    icon: Icons.event,
                    label: "Predstave",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PredstavaListScreen()));
                    }
                  ),
                  _buildDrawerItem(
                    icon: Icons.schedule,
                    label: "Repertoari",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => RepertoarListScreen()));
                    }
                  ),
                  _buildDrawerItem(
                    icon: Icons.bookmark_border,
                    label: "Rezervacije",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => RezervacijaListScreen()));
                    }
                  ),
                  _buildDrawerItem(
                    icon: Icons.receipt_long,
                    label: "Stavke uplata",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => StavkaUplateListScreen()));
                    }
                  ),
                  _buildDrawerItem(
                    icon: Icons.timer_outlined,
                    label: "Termini",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => TerminListScreen()));
                    }
                  ),
                  _buildDrawerItem(
                    icon: Icons.payment,
                    label: "Uplate",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => UplataListScreen()));
                    }
                  ),
                  _buildDrawerItem(
                    icon: Icons.newspaper,
                    label: "Vijesti",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => VijestListScreen()));
                    }
                  ),
                  _buildDrawerItem(
                    icon: Icons.category,
                    label: "Zanrovi",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ZanrListScreen()));
                    }
                  ),
                ],
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade900,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false,
                );
                AuthProvider.username = "";
                AuthProvider.password = "";
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                "Odjavi se",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              )
            )
            
            
          ]
        )
      );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color.fromARGB(255, 72, 142, 255)),
      title: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}
