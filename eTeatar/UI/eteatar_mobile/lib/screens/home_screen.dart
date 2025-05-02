import 'package:eteatar_mobile/screens/obavijesti_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(child: Icon(Icons.person)),
              const SizedBox(width: 20),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Pretraži eTeatar',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.mail_outline),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ObavijestiScreen()));
                },
              )
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'PREPORUČENO',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildRecommendedCard('Seljačka opera', 'Drama'),
                _buildRecommendedCard('Realisti', 'Opera'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'REZERVACIJE',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              title: const Text('Nadrealisti, Opera'),
              subtitle: const Text('Jun 19 2024.'),
              trailing: const Text(
                '18:00h',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedCard(String title, String genre) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.image, size: 80, color: Colors.grey),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(genre, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
  
}
