import 'dart:convert';
import 'dart:io';

import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/korisnik.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/uloga.dart';
import 'package:eteatar_desktop/providers/korisnik_provider.dart';
import 'package:eteatar_desktop/providers/uloga_provider.dart';
import 'package:eteatar_desktop/screens/korisnik_list_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class KorisnikDetailsScreen extends StatefulWidget {
  final Korisnik? korisnik;
  const KorisnikDetailsScreen({super.key, this.korisnik});

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
        text: "$e",
        width: 300
      );
    }
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
                      FormBuilderValidators.required(errorText: "Obavezno polje"),
                      FormBuilderValidators.match(
                        r'^[A-ZČĆŽĐŠ][a-zA-ZčćžđšČĆŽĐŠ]*$', 
                        errorText: "Ime mora počinjati sa velikim slovom i smije sadržavati samo slova."),
                      FormBuilderValidators.maxLength(255, errorText: "Maksimalna dužina je 255 karaktera!"),
                    ]),
                    )
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: FormBuilderTextField(
                    name: "Prezime",
                    decoration: InputDecoration(labelText: "Prezime"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: "Obavezno polje"),
                      FormBuilderValidators.match(
                        r'^[A-ZČĆŽĐŠ][a-zA-ZčćžđšČĆŽĐŠ]*$', 
                        errorText: "Prezime mora počinjati sa velikim slovom i smije sadržavati samo slova."),
                      FormBuilderValidators.maxLength(255, errorText: "Maksimalna dužina je 255 karaktera!"),
                    ]),
                    )
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: FormBuilderTextField(
                    name: "KorisnickoIme",
                    decoration: InputDecoration(labelText: "Korisnicko ime"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: "Obavezno polje"),
                      FormBuilderValidators.maxLength(255, errorText: "Maksimalna dužina je 255 karaktera!"),
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
                   validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    (value) {
                      if (value == null) return null;
                      if (value.isBefore(DateTime(1900, 1, 1))) {
                        return "Datum rođenja ne može biti manji od 1900.01.01.";
                      }
                      return null;
                    }
                  ]),
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
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    FormBuilderValidators.email(errorText: "Unesite ispravnu email adresu!"),
                    FormBuilderValidators.maxLength(255, errorText: "Maksimalna dužina je 255 karaktera!"),
                  ]),
                  )
              ),
              SizedBox(width: 10,),
              Expanded(
                child: FormBuilderTextField(
                  name: "Telefon",
                  decoration: InputDecoration(labelText: "Telefon"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    FormBuilderValidators.match(
                      r'^\+\d{7,15}$',
                    errorText: "Telefon mora imati od 7 do 15 cifara \ni počinjati znakom +."),
                    FormBuilderValidators.maxLength(255, errorText: "Maksimalna dužina je 255 karaktera!"),
                  ]),
                ),
              ),
            ],
            ),
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
            var formCheck = _formKey.currentState?.saveAndValidate();
            if(formCheck == true) {
              final formData = _formKey.currentState!.value;

              final requestData = {
                ...formData,
                'DatumRodenja': DateFormat('yyyy-MM-dd').format(formData['DatumRodenja']),
                'Slika': _base64Image,
              };
              if(widget.korisnik == null){
                try {
                  await _korisnikProvider.insert(requestData);
                  QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: "Uspješno dodat korisnik!",
                  width: 300,
                  onConfirmBtnTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const KorisnikListScreen(),
                      ),
                    );
                  },
                );
                } catch (e){
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri dodavanju korisnika!",
                    text: "$e",
                    width: 300
                  );
                }
              } else {
                try {
                  await _korisnikProvider.update(widget.korisnik!.korisnikId!, requestData);
                  QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: "Uspješno ažuriran korisnik!",
                  width: 300,
                  onConfirmBtnTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const KorisnikListScreen(),
                      ),
                    );
                  },
                );
                } catch (e){
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri ažuriranju korisnika!",
                    text: "$e",
                    width: 300
                  );
                }
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