import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class ZanrListScreen extends StatefulWidget {
  const ZanrListScreen({super.key});

  @override
  State<ZanrListScreen> createState() => _ZanrListScreenState();
}

class _ZanrListScreenState extends State<ZanrListScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista zanrova", Column(
      children: [
        Text("Lista zanrova placeholder"),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: const Text("Nazad"),),
      ],
    ),);
  }
}