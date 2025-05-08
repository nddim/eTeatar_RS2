import 'dart:convert';
import 'dart:io';

import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/glumac.dart';
import 'package:eteatar_desktop/models/predstava.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/zanr.dart';
import 'package:eteatar_desktop/providers/glumac_provider.dart';
import 'package:eteatar_desktop/providers/predstava_provider.dart';
import 'package:eteatar_desktop/providers/zanr_provider.dart';
import 'package:eteatar_desktop/screens/predstava_list_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:quickalert/quickalert.dart';

class PredstavaDetailsScreen extends StatefulWidget {
  final Predstava? predstava;
  const PredstavaDetailsScreen({super.key, this.predstava});

  @override
  State<PredstavaDetailsScreen> createState() => _PredstavaDetailsScreenState();
}

class _PredstavaDetailsScreenState extends State<PredstavaDetailsScreen> {

  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late PredstavaProvider _predstavaProvider;
  late GlumacProvider _glumacProvider;
  late ZanrProvider _zanrProvider;
  SearchResult<Glumac>? glumacResult = null;
  SearchResult<Glumac>? initialGlumacResult = null;
  SearchResult<Zanr>? zanrResult = null;
  SearchResult<Zanr>? initialZanrResult = null;

  bool isLoading = true;
  List<int> _selectedZanrovi = [];
  List<int> _selectedGlumci = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {

    _predstavaProvider = context.read<PredstavaProvider>();
    _glumacProvider = context.read<GlumacProvider>();
    _zanrProvider = context.read<ZanrProvider>();

    super.initState();

    _initialValue = {
      "Naziv" : widget.predstava?.naziv ?? "",
      "Cijena" : widget.predstava?.cijena.toString() ?? "",
      "Slika" : widget.predstava?.slika ?? "",
      "Opis" : widget.predstava?.opis ?? "",
      "Produkcija" : widget.predstava?.produkcija ?? "",
      "Koreografija" : widget.predstava?.koreografija ?? "",
      "Scenografija" : widget.predstava?.scenografija ?? "",
      "TrajanjePocetak" : widget.predstava?.trajanjePocetak,
      "TrajanjeKraj" : widget.predstava?.trajanjeKraj,
    };

    initForm();
  }

  Future initForm() async {
    try {
      glumacResult = await _glumacProvider.get(filter: { 'isDeleted': false});
    } catch (e){
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju glumaca!",
        width: 300
      );
    }
    try {
      zanrResult = await _zanrProvider.get(filter: { 'isDeleted': false});
    } catch (e){
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju zanrova!",
        width: 300
      );
    }
    if(widget.predstava != null){
      try {
        initialGlumacResult = await _glumacProvider.get(filter: { "predstavaId" : widget.predstava!.predstavaId,'isDeleted': false});
        if (initialGlumacResult != null) {
          _selectedGlumci = initialGlumacResult!.resultList.map((e) => e.glumacId!).toList();
        }
      } catch (e){
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Greška pri dohvatanju glumaca!",
          width: 300
        );
      }
      try {
        initialZanrResult = await _zanrProvider.get( filter: { "predstavaId" : widget.predstava!.predstavaId,'isDeleted': false});
        if (initialZanrResult != null) {
          _selectedZanrovi = initialZanrResult!.resultList.map((e) => e.zanrId!).toList();
        }
      } catch (e){
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Greška pri dohvatanju zanrova!",
          width: 300
        );
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen("Predstava detalji", 
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
                    name: "Naziv",
                    decoration: InputDecoration(labelText: "Naziv"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: "Obavezno polje"),
                      FormBuilderValidators.maxLength(255, errorText: "Maksimalna dužina je 255 karaktera!"),
                    ]),
                    )
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: FormBuilderTextField(
                    name: "Cijena",
                    decoration: InputDecoration(labelText: "Cijena"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: "Obavezno polje"),
                      FormBuilderValidators.numeric(errorText: "Unos mora biti broj!"),
                      FormBuilderValidators.max(10000, errorText: "Cijena ne smije biti veca od 10000 KM!"),
                      FormBuilderValidators.min(1, errorText: "Cijena ne smije biti manja od 1 KM"),
                    ]),
                    )
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: FormBuilderTextField(
                    name: "Opis",
                    decoration: InputDecoration(labelText: "Opis"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: "Obavezno polje"),
                      FormBuilderValidators.maxLength(255, errorText: "Maksimalna dužina je 255 karaktera!"),

                    ]),
                  ),
                ),
              ]
            ),
            Row(children: [
              Expanded(
                child: FormBuilderTextField(
                  name: "Produkcija",
                  decoration: InputDecoration(labelText: "Produkcija"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    FormBuilderValidators.maxLength(255, errorText: "Maksimalna dužina je 255 karaktera!"),
                    
                  ]),
                ),
              ),
              SizedBox(width: 10,),  // Razmak između polja
              Expanded(
                child: FormBuilderTextField(
                  name: "Koreografija",
                  decoration: InputDecoration(labelText: "Koreografija"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    FormBuilderValidators.maxLength(255, errorText: "Maksimalna dužina je 255 karaktera!"),
                  ]),
                ),
              ),
              SizedBox(width: 10,),  // Razmak između polja
              Expanded(
                child: FormBuilderTextField(
                  name: "Scenografija",
                  decoration: InputDecoration(labelText: "Scenografija"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    FormBuilderValidators.maxLength(255, errorText: "Maksimalna dužina je 255 karaktera!"),
                  ]),
                ),
              ),
            ],),
            Row(
              children: [
                Expanded(
                  child: 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MultiSelectDialogField<int>(
                      items: zanrResult?.resultList
                          .map((e) => MultiSelectItem<int>(e.zanrId!, e.naziv ?? ""))
                          .toList() ?? [],
                      initialValue: _selectedZanrovi,
                      title: Text("Odaberi žanrove"),
                      selectedColor: Colors.blue,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      buttonText: Text("Žanrovi"),
                      onConfirm: (values) {
                        _selectedZanrovi = values.cast<int>();
                      },
                      validator: (values) {
                        if (values == null || values.isEmpty) {
                          return "Odaberite barem jedan žanr";
                        }
                        return null;
                      },
                    ),
                  )
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MultiSelectDialogField(
                      items: glumacResult?.resultList
                          .map((e) => MultiSelectItem<int>(e.glumacId!, "${e.ime} ${e.prezime}"))
                          .toList() ?? [],
                      initialValue: _selectedGlumci,
                      title: Text("Odaberi glumce"),
                      selectedColor: Colors.blue,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      buttonText: Text("Glumci"),
                      onConfirm: (values) {
                        _selectedGlumci = values.cast<int>();
                      },
                      validator: (values) {
                        if (values == null || values.isEmpty) {
                          return "Odaberite barem jednog glumca";
                        }
                        return null;
                      },
                    ),
                  )
                )
              ]
            ),
            Row(children: [
              Expanded(child: 
                FormBuilderDateTimePicker(
                  name: "TrajanjePocetak",
                  decoration: InputDecoration(labelText: "Trajanje početak"),
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
              Expanded(child: 
                FormBuilderDateTimePicker(
                  name: "TrajanjeKraj",
                  decoration: InputDecoration(labelText: "Trajanje kraj"),
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
              )
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
                'TrajanjePocetak': DateFormat('yyyy-MM-dd').format(formData['TrajanjePocetak']),
                'TrajanjeKraj': DateFormat('yyyy-MM-dd').format(formData['TrajanjeKraj']),
                'Slika': _base64Image ?? widget.predstava?.slika,
                'Zanrovi': _selectedZanrovi,
                'Glumci': _selectedGlumci,
              };
              if(widget.predstava == null){
                try {
                  await _predstavaProvider.insert(requestData);
                  QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: "Uspješno dodana predstava!",
                  width: 300,
                  onConfirmBtnTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PredstavaListScreen(),
                      ),
                    );
                  },
                );
                } catch (e) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri azuriranju predstave!",
                    width: 300
                  );
                }
              } else {
                try {
                  await _predstavaProvider.update(widget.predstava!.predstavaId!, requestData);
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: "Uspješno ažurirana predstava!",
                    width: 300,
                    onConfirmBtnTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PredstavaListScreen(),
                        ),
                      );
                    },
                  );
                } catch (e) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri ažuriranju predstave!",
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

