import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class DvoranaListScreen extends StatefulWidget {
  const DvoranaListScreen({super.key});

  @override
  State<DvoranaListScreen> createState() => _DvoranaListScreenState();
}

class _DvoranaListScreenState extends State<DvoranaListScreen> {
  @override
  Widget build(BuildContext context) {
     return MasterScreen("Lista dvorana", Column(
      children: [
        Text("Lista dvorana placeholder"),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: const Text("Nazad"),),
      ],
    ),); 
  }
}