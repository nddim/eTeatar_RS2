import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class HranaListScreen extends StatefulWidget {
  const HranaListScreen({super.key});

  @override
  State<HranaListScreen> createState() => _HranaListScreenState();
}

class _HranaListScreenState extends State<HranaListScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista hrane", Column(
      children: [
        Text("Lista hrane placeholder"),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: const Text("Nazad"),),
      ],
    ),);
  }
}