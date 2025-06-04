import 'dart:convert';
import 'dart:io';

import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/main.dart';
import 'package:eteatar_desktop/providers/auth_provider.dart';
import 'package:eteatar_desktop/providers/korisnik_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class KorisnickiProfilScreen extends StatefulWidget {
  const KorisnickiProfilScreen({Key? key}) : super(key: key);

  @override
  State<KorisnickiProfilScreen> createState() => _KorisnickiProfilScreenScreenState();
}

class _KorisnickiProfilScreenScreenState extends State<KorisnickiProfilScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KorisnikProvider korisnikProvider;
  String? _base64Image;
  File? _image;
  bool promijeniLozinku = false;

  @override
  void initState() {
    super.initState();
    korisnikProvider = context.read<KorisnikProvider>();
    _base64Image = AuthProvider.slika;
  }

  @override
Widget build(BuildContext context) {
  return MasterScreen(
    "Korisnički profil",
    buildProfil(),
  );
}

Widget buildProfil() {
  final initialValues = {
    "Ime": AuthProvider.ime,
    "Prezime": AuthProvider.prezime,
    "Email": AuthProvider.email,
    "Telefon": AuthProvider.telefon,
  };

  return SingleChildScrollView(
    padding: const EdgeInsets.all(12),
    child: FormBuilder(
      key: _formKey,
      initialValue: initialValues,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: _buildProfileImage(AuthProvider.slika)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  name: "Ime",
                  decoration: const InputDecoration(labelText: "Ime"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    FormBuilderValidators.match(
                      r'^[A-ZČĆŽĐŠ][a-zA-ZčćžđšČĆŽĐŠ]*$',
                      errorText: "Ime mora početi velikim slovom i sadržavati samo slova.",
                    ),
                    FormBuilderValidators.minLength(3,
                        errorText: "Minimalno 3 karaktera"),
                    FormBuilderValidators.maxLength(30,
                        errorText: "Maksimalno 30 karaktera"),
                  ]),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FormBuilderTextField(
                  name: "Prezime",
                  decoration: const InputDecoration(labelText: "Prezime"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    FormBuilderValidators.match(
                      r'^[A-ZČĆŽĐŠ][a-zA-ZčćžđšČĆŽĐŠ]*$',
                      errorText: "Prezime mora početi velikim slovom i sadržavati samo slova.",
                    ),
                    FormBuilderValidators.minLength(3,
                        errorText: "Minimalno 3 karaktera"),
                    FormBuilderValidators.maxLength(30,
                        errorText: "Maksimalno 30 karaktera"),
                  ]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  name: "Email",
                  decoration: const InputDecoration(labelText: "Email"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    FormBuilderValidators.email(errorText: "Neispravan email"),
                    FormBuilderValidators.maxLength(255,
                        errorText: "Maksimalno 255 karaktera"),
                  ]),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FormBuilderTextField(
                  name: "Telefon",
                  decoration: const InputDecoration(labelText: "Telefon"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    FormBuilderValidators.match(
                      r'^\+\d{7,15}$',
                      errorText: "Telefon mora početi znakom + i imati 7–15 cifara.",
                    ),
                    FormBuilderValidators.maxLength(255,
                        errorText: "Maksimalno 255 karaktera"),
                  ]),
                ),
              ),
            ],
          ),
          Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: FormBuilderCheckbox(
                  initialValue: promijeniLozinku,
                  name: 'promijeniLozinku',
                  title: const Text("Promijeni lozinku"),
                  onChanged: (value) => {
                    setState(() {
                      promijeniLozinku = value!;
                    })
                  },
                )),
                const SizedBox(
                  width: 10,
                ),
              ],
          ),
          if (promijeniLozinku == true)
            Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: FormBuilderTextField(
                    decoration: const InputDecoration(labelText: "Nova lozinka"),
                    name: 'lozinka',
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: "Obavezno polje"),
                      FormBuilderValidators.minLength(4,
                        errorText: "Lozinka mora sadržavati najmanje 4 karaktera"),
                      FormBuilderValidators.maxLength(30,
                        errorText: "Lozinka može sadržavati najviše 30 karaktera"),
                    ]),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FormBuilderTextField(
                    decoration: const InputDecoration(labelText: "Potvrdi lozinku"),
                    name: 'lozinkaPotvrda',
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: "Obavezno polje"),
                      FormBuilderValidators.minLength(4,
                        errorText: "Lozinka mora sadržavati najmanje 4 karaktera"),
                      FormBuilderValidators.maxLength(30,
                        errorText: "Lozinka može sadržavati najviše 30 karaktera"),
                    ]),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          const SizedBox(height: 10),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.upload),
            label: const Text("Odaberi sliku"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveProfile,
            child: const Text("Sačuvaj"),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildProfileImage(String? base64Image) {
    if (_image != null) {
      // Prikaz lokalno odabrane slike
      return CircleAvatar(
        radius: 60,
        backgroundImage: FileImage(_image!),
      );
    } else if (base64Image != null && base64Image.isNotEmpty) {
      // Prikaz slike iz base64 stringa
      return CircleAvatar(
        radius: 60,
        backgroundImage: MemoryImage(base64Decode(base64Image)),
      );
    } else {
      // Default avatar
      return const CircleAvatar(
        radius: 60,
        child: Icon(Icons.person, size: 60),
      );
    }
  }

  void _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base64Image = base64Encode(_image!.readAsBytesSync());
      setState(() {});
    }
  }

  void _saveProfile() async {
  if (_formKey.currentState?.saveAndValidate() ?? false) {
    final formData = _formKey.currentState!.value;

    final request = {
      "Ime": formData["Ime"],
      "Prezime": formData["Prezime"],
      "Email": formData["Email"],
      "Telefon": formData["Telefon"],
      "Slika": _base64Image,
    };

    if (promijeniLozinku) {
      request["Lozinka"] = formData["lozinka"];
      request["LozinkaPotvrda"] = formData["lozinkaPotvrda"];
    }

    try {
      await korisnikProvider.update(AuthProvider.korisnikId!, request);
      if (!mounted) return;
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: "Uspješno modifikovan profil",
        confirmBtnText: 'OK',
        barrierDismissible: true,
      );
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
      AuthProvider.username = "";
      AuthProvider.password = "";
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri ažuriranju profila!",
        text: "$e",
        width: 300,
      );
    } finally {
      _resetLozinke();
    }
  }
}

void _resetLozinke() {
  setState(() {
    _formKey.currentState?.fields['lozinka']?.didChange(null);
    _formKey.currentState?.fields['lozinkaPotvrda']?.didChange(null);
    promijeniLozinku = false;
  });
}
}