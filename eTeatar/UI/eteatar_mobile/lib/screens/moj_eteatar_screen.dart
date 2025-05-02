import 'package:eteatar_mobile/main.dart';
import 'package:eteatar_mobile/providers/auth_provider.dart';
import 'package:flutter/material.dart';

class MojEteatarScreen extends StatefulWidget {
  const MojEteatarScreen({super.key});

  @override
  State<MojEteatarScreen> createState() => _MojEteatarScreenState();
}

class _MojEteatarScreenState extends State<MojEteatarScreen> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moj eTeatar'),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTile(context, Icons.event, 'Rezervacije', () {
            // Navigacija na rezervacije
          }),
          _buildSectionTile(context, Icons.history, 'Arhiva predstava', () {
            // Navigacija na arhivu
          }),
          _buildSectionTile(context, Icons.payment, 'Uplate', () {
            // Navigacija na uplate
          }),
          _buildSectionTile(context, Icons.person, 'Moj profil', () {
            // Navigacija na profil
          }),
          _buildSectionTile(
            context,
            Icons.logout,
            'Odjavi se',
            () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false,
                );
                AuthProvider.username = "";
                AuthProvider.password = "";
            },
            color: Colors.redAccent,
            iconColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTile(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color? color,
    Color? iconColor,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? Colors.blue),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: color ?? Colors.black,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}