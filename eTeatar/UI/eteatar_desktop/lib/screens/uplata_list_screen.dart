import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class UplataListScreen extends StatefulWidget {
  const UplataListScreen({super.key});

  @override
  State<UplataListScreen> createState() => _UplataListScreenState();
}

class _UplataListScreenState extends State<UplataListScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista uplata", Column(
      children: [
        Text("Lista uplata placeholder"),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: const Text("Nazad"),),
      ],
    ),);
  }
}