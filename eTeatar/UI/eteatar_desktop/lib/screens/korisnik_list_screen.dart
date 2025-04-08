import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class KorisnikListScreen extends StatelessWidget {
  const KorisnikListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista korisnika", Column(
      children: [
        Text("Lista korisnika placeholder"),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: const Text("Nazad"),),
      ],
    ),); 
  }
}