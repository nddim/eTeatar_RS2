import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class PredstavaListScreen extends StatelessWidget {
  const PredstavaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista predstava", Column(
      children: [
        Text("Lista predstava placeholder"),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: const Text("Nazad"),),
      ],
    ),); 
  }
}