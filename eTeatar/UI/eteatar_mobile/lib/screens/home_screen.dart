import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predstave'),
        backgroundColor: Colors.lightBlue,
      ),
      body: const Center(
        child: Text(
          'Ovdje će biti lista predstava',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
  
}
