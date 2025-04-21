import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class OcjenaListScreen extends StatefulWidget {
  const OcjenaListScreen({super.key});

  @override
  State<OcjenaListScreen> createState() => _OcjenaListScreenState();
}

class _OcjenaListScreenState extends State<OcjenaListScreen> {
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