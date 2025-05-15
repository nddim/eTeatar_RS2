import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:eteatar_mobile/main.dart';
import 'package:eteatar_mobile/providers/auth_provider.dart';
import 'package:eteatar_mobile/providers/korisnik_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class KorisnickiProfil extends StatefulWidget {
  const KorisnickiProfil({super.key});

  @override
  State<KorisnickiProfil> createState() => _KorisnickiProfilState();
}

class _KorisnickiProfilState extends State<KorisnickiProfil> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KorisnikProvider korisnikProvider;
  bool promijeniLozinku = false;
  Map<String, dynamic> _initialValue = {};
  @override
  void initState() {
    korisnikProvider = context.read<KorisnikProvider>();
    super.initState();
    _base64Image = AuthProvider.slika;
     _initialValue = {
      'ime': AuthProvider.ime,
      'prezime': AuthProvider.prezime,
      'telefon': AuthProvider.telefon,
      'email': AuthProvider.email,
      'slika': AuthProvider.slika,
      'lozinka': null,
      'lozinkaPotvrda': null
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moj profil'),
        backgroundColor: Colors.lightBlue,
      ),
      body : _buildPage()
    );
  }

  Widget _buildPage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(children: [_buildProfileHeader(), _saveRow()]),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: 
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        image: AuthProvider.slika != null
                            ? DecorationImage(
                                image: MemoryImage(base64Decode(AuthProvider.slika!)),
                                fit: BoxFit.cover,
                              )
                            : const DecorationImage(
                                image: AssetImage("assets/images/noProfileImg.png"),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            // const SizedBox(height: 10),
            // const Text("Dodirnite sliku za promjenu", style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 5),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Ime", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
                  name: 'ime',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    FormBuilderValidators.minLength(2,
                        errorText: "Minimalna dužina je 2 znaka"),
                    FormBuilderValidators.maxLength(50,
                        errorText: "Maksimalna dužina je 50 znakova"),
                  ]),
                )),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Prezime", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
                  name: 'prezime',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    FormBuilderValidators.minLength(2,
                        errorText: "Minimalna dužina je 2 znaka"),
                    FormBuilderValidators.maxLength(50,
                        errorText: "Maksimalna dužina je 50 znakova"),
                  ]),
                )),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Telefon", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
                  name: 'telefon',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    FormBuilderValidators.match(r'^\+\d{7,15}$',
                        errorText:
                            "Telefon ima od 7 do 15 cifara i počinje znakom+"),
                  ]),
                )),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
                  name: 'email',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    FormBuilderValidators.email(errorText: "Unesite ispravnu email adresu!"),
                    FormBuilderValidators.maxLength(100,
                        errorText: "Maksimalno 50 znakova"),
                  ]),
                )),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: 
                  FormBuilderField(
                    name: "slika",
                    builder: (field) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Odaberite sliku',
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 108, 108, 108),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        child: ListTile(
                          leading: Icon(Icons.image),
                          title: Text("Select image"),
                          trailing: Icon(Icons.file_upload),
                          onTap: getImage,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
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
              Container(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FormBuilderTextField(
                      decoration: InputDecoration(labelText: "Nova lozinka", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
                      name: 'lozinka',
                      obscureText: true,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Obavezno polje"),
                      ]),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            if (promijeniLozinku == true)
              Container(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FormBuilderTextField(
                      decoration: InputDecoration(labelText: "Potvrdi lozinka", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
                      name: 'lozinkaPotvrda',
                      obscureText: true,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Obavezno polje"),
                      ]),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _saveRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            var formCheck = _formKey.currentState?.saveAndValidate();
            if (formCheck == true) {
              var request = Map.from(_formKey.currentState!.value);
              try {
                request['slika'] = _base64Image;
                await korisnikProvider.update(AuthProvider.korisnikId!, request);
                resetPassword();
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
              } on Exception catch (e) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: e.toString(),
                );
                resetPassword();
              }
            }
          },
          child: const Text("Sačuvaj"),
        ),
      ),
    );
  }
  void resetPassword() {
    setState(() {
      _formKey.currentState?.fields['lozinka']?.didChange(null);
      _formKey.currentState?.fields['lozinkaPotvrda']?.didChange(null);
    });
  }
  File? _image;
  String? _base64Image;

  void getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base64Image = base64Encode(_image!.readAsBytesSync());
    }
  }
}