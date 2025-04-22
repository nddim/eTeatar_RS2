import 'dart:convert';
import 'dart:io';

import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/korisnik.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/uloga.dart';
import 'package:eteatar_desktop/providers/korisnik_provider.dart';
import 'package:eteatar_desktop/providers/uloga_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class KorisnikDetailsScreen extends StatefulWidget {
  Korisnik? korisnik;
  KorisnikDetailsScreen({super.key, this.korisnik});

  @override
  State<KorisnikDetailsScreen> createState() => _KorisnikDetailsScreenState();
}

class _KorisnikDetailsScreenState extends State<KorisnikDetailsScreen> {

  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late KorisnikProvider _korisnikProvider;
  late UlogaProvider _ulogaProvider;
  SearchResult<Uloga>? ulogaResult = null;
  bool isLoading = true;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {

    _korisnikProvider = context.read<KorisnikProvider>();
    _ulogaProvider = context.read<UlogaProvider>();

    super.initState();

    _initialValue = {
      "Ime" : widget.korisnik?.ime ?? "",
      "Prezime" : widget.korisnik?.prezime ?? "",
      "Email" : widget.korisnik?.email ?? "",
      "Telefon" : widget.korisnik?.telefon ?? "",
      "KorisnickoIme" : widget.korisnik?.korisnickoIme ?? "",
      "Slika" : widget.korisnik?.slika ?? "",
      "DatumRodenja" : widget.korisnik?.datumRodenja ?? DateTime.now(),
    };

    initForm();
  }

   Future initForm() async {
    try {
      ulogaResult = await _ulogaProvider.get();
    } catch (e){
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju uloga!",
        width: 300
      );
    }
    print("zanrResult: ${ulogaResult?.resultList.length}");

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen("Korisnik detalji", 
      Column(children: [
        isLoading ? Container() : _buildForm(), _save(),
      ],)
    ) ;
  }

  Widget _buildForm() {
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
                  child: FormBuilderTextField(
                    name: "Ime",
                    decoration: InputDecoration(labelText: "Ime"),
                    validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    ]),
                    )
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: FormBuilderTextField(
                    name: "Prezime",
                    decoration: InputDecoration(labelText: "Prezime"),
                    validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    ]),
                    )
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: FormBuilderTextField(
                    name: "KorisnickoIme",
                    decoration: InputDecoration(labelText: "Korisnicko ime"),
                    validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    ]),
                    )
                ),
                
              ]
            ),
            
            Row(children: [
              Expanded(child: 
                FormBuilderDateTimePicker(
                  name: "DatumRodenja",
                  decoration: InputDecoration(labelText: "Datum rođenja"),
                  validator: FormBuilderValidators.required(),
                  inputType: InputType.date,
                  format: DateFormat("yyyy-MM-dd"),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: FormBuilderTextField(
                  name: "Email",
                  decoration: InputDecoration(labelText: "Email"),
                  validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  ]),
                  )
              ),
              SizedBox(width: 10,),
              Expanded(
                child: FormBuilderTextField(
                  name: "Telefon",
                  decoration: InputDecoration(labelText: "Telefon"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
            ],
            ),
            Row(children: [
              Expanded(
                child: FormBuilderTextField(
                  name: "Lozinka",
                  decoration: InputDecoration(labelText: "Lozinka"),
                  validator: FormBuilderValidators.compose([
                    
                  ]),
                ),
              ),
              SizedBox(width: 10,),  // Razmak između polja
              Expanded(
                child: FormBuilderTextField(
                  name: "LozinkaPotvrda",
                  decoration: InputDecoration(labelText: "Lozinka potvrda"),
                  validator: FormBuilderValidators.compose([
                    
                  ]),
                ),
              ),
            ],),
            Row(children: [
              Expanded(
                child: FormBuilderField(
                  name: "Slika",
                  builder: (field) {
                    return InputDecorator(decoration: 
                    InputDecoration(
                      labelText: "Odaberite sliku"),
                      child: ListTile(
                        leading:Icon(Icons.image),
                        title: Text("Upload image"),
                        trailing: Icon(Icons.file_upload),
                        onTap: getImage,
                      )
                    );
                  },
                  
                )
              )
            ],)
          ],
        ),
      ),
    );
  }

  Widget _save() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(onPressed: () async{
            _formKey.currentState?.saveAndValidate();
            final formData = _formKey.currentState!.value;

            final requestData = {
              ...formData,
              'DatumRodenja': DateFormat('yyyy-MM-dd').format(formData['DatumRodenja']),
              'Slika': _base64Image,
            };
            if(widget.korisnik == null){
              try {
                _korisnikProvider.insert(requestData);
              } catch (e){
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: "Greška pri dodavanju korisnika!",
                  width: 300
                );
              }
            } else {
              try {
                _korisnikProvider.update(widget.korisnik!.korisnikId!, requestData);
              } catch (e){
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: "Greška pri ažuriranju korisnika!",
                  width: 300
                );
              }
            }
          }, 
          child: const Text("Sačuvaj")),
      ],),
    );
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