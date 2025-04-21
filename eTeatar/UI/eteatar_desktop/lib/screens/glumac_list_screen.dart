import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class GlumacListScreen extends StatefulWidget {
  const GlumacListScreen({super.key});

  @override
  State<GlumacListScreen> createState() => _GlumacListScreenState();
}

class _GlumacListScreenState extends State<GlumacListScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen("Lista glumaca", Column(
      children: [
        Text("Lista glumaca placeholder"),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: const Text("Nazad"),),
      ],
    ),);
  }
}