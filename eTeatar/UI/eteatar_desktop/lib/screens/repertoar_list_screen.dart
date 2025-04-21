import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class RepertoarListScreen extends StatefulWidget {
  const RepertoarListScreen({super.key});

  @override
  State<RepertoarListScreen> createState() => _RepertoarListScreenState();
}

class _RepertoarListScreenState extends State<RepertoarListScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista repertoara", Column(
      children: [
        Text("Lista repertoara placeholder"),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: const Text("Nazad"),),
      ],
    ),);
  }
}