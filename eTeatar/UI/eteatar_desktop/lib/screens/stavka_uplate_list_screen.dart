import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class StavkaUplateListScreen extends StatefulWidget {
  const StavkaUplateListScreen({super.key});

  @override
  State<StavkaUplateListScreen> createState() => _StavkaUplateListScreenState();
}

class _StavkaUplateListScreenState extends State<StavkaUplateListScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista stavki uplata", Column(
      children: [
        Text("Lista stavki uplata placeholder"),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: const Text("Nazad"),),
      ],
    ),);
  }
}