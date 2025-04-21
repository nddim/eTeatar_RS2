import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class TerminListScreen extends StatefulWidget {
  const TerminListScreen({super.key});

  @override
  State<TerminListScreen> createState() => _TerminListScreenState();
}

class _TerminListScreenState extends State<TerminListScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista termina", Column(
      children: [
        Text("Lista termina placeholder"),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: const Text("Nazad"),),
      ],
    ),);
  }
}