import 'package:eteatar_mobile/providers/auth_provider.dart';
import 'package:flutter/material.dart';

class KorisnickiProfil extends StatefulWidget {
  const KorisnickiProfil({super.key});

  @override
  State<KorisnickiProfil> createState() => _KorisnickiProfilState();
}

class _KorisnickiProfilState extends State<KorisnickiProfil> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _imeController.text = AuthProvider.ime ?? '';
    _prezimeController.text = AuthProvider.prezime ?? '';
    _telefonController.text = AuthProvider.telefon ?? '';
    _emailController.text = AuthProvider.email ?? '';
  }

  final TextEditingController _imeController = TextEditingController(text: "Ime");
  final TextEditingController _prezimeController = TextEditingController(text: "Prezime");
  final TextEditingController _telefonController = TextEditingController(text: "+38761123456");
  final TextEditingController _emailController = TextEditingController(text: "ime.prezime@email.com");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moj profil'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 24),
              _buildTextField(_imeController, 'Ime'),
              const SizedBox(height: 12),
              _buildTextField(_prezimeController, 'Prezime'),
              const SizedBox(height: 12),
              _buildTextField(_telefonController, 'Telefon'),
              const SizedBox(height: 12),
              _buildTextField(_emailController, 'Email'),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  // to do sifra promjena
                },
                icon: const Icon(Icons.lock_outline),
                label: const Text("Promijeni šifru"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Unesite $label';
        }
        return null;
      },
    );
  }
}