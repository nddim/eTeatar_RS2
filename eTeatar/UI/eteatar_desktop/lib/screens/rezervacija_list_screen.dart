import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class RezervacijaListScreen extends StatefulWidget {
  const RezervacijaListScreen({super.key});

  @override
  State<RezervacijaListScreen> createState() => _RezervacijaListScreenState();
}

class _RezervacijaListScreenState extends State<RezervacijaListScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista rezervacija", Column(
      children: [
        Text("Lista rezervacija placeholder"),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: const Text("Nazad"),),
      ],
    ),);
  }
}