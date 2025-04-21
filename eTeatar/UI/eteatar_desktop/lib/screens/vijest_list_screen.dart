import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class VijestListScreen extends StatefulWidget {
  const VijestListScreen({super.key});

  @override
  State<VijestListScreen> createState() => _VijestListScreenState();
}

class _VijestListScreenState extends State<VijestListScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista vijesti", Column(
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