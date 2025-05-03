import 'dart:convert';
import 'dart:io';

import 'package:eteatar_mobile/main.dart';
import 'package:eteatar_mobile/providers/auth_provider.dart';
import 'package:eteatar_mobile/providers/korisnik_provider.dart';
import 'package:eteatar_mobile/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class KorisnickiProfil extends StatefulWidget {
  const KorisnickiProfil({super.key});

  @override
  State<KorisnickiProfil> createState() => _KorisnickiProfilState();
}

class _KorisnickiProfilState extends State<KorisnickiProfil> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImageFile;
  String? _base64Image;
  final ImagePicker _picker = ImagePicker();
  late KorisnikProvider korisnikProvider;

  @override
  void initState() {
    korisnikProvider = context.read<KorisnikProvider>();
    super.initState();
    _base64Image = AuthProvider.slika;
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
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade300,
                  child: _selectedImageFile != null
                      ? ClipOval(child: Image.file(_selectedImageFile!, fit: BoxFit.cover, width: 100, height: 100))
                      : (_base64Image != null
                          ? ClipOval(child: imageFromString(_base64Image!))
                          : const Icon(Icons.person, size: 50)),
                ),
              ),
              const SizedBox(height: 8),
              const Text("Dodirnite sliku za promjenu", style: TextStyle(fontSize: 12, color: Colors.grey)),
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
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _saveChanges,
                icon: const Icon(Icons.save),
                label: const Text("Sačuvaj izmjene"),
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

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _selectedImageFile = File(picked.path);
        _base64Image = base64Encode(bytes);
      });
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final Map<String, dynamic> updateData = {
        'ime': _imeController.text,
        'prezime': _prezimeController.text,
        'telefon': _telefonController.text,
        'email': _emailController.text,
        if (_base64Image != null) 'slika': _base64Image
      };

      await korisnikProvider.update(AuthProvider.korisnikId!, updateData);

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Profil uspješno ažuriran',
        confirmBtnText: 'OK',
        onConfirmBtnTap: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
          );
          AuthProvider.username = "";
          AuthProvider.password = "";
        },
      );

      
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Greška pri ažuriranju profila',
      );
    }
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