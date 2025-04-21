import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class KartaListScreen extends StatefulWidget {
  const KartaListScreen({super.key});

  @override
  State<KartaListScreen> createState() => _KartaListScreenState();
}

class _KartaListScreenState extends State<KartaListScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista karata", Column(
      children: [
        Text("Lista karata placeholder"),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: const Text("Nazad"),),
      ],
    ),);
  }
}