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
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PredstavaDetailsScreen extends StatefulWidget {
  Predstava? predstava;
  PredstavaDetailsScreen({super.key, this.predstava});

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
  SearchResult<Zanr>? zanrResult = null;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    
  }

  @override
  void initState() {
    // TODO: implement initState

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
    glumacResult = await _glumacProvider.get();
    zanrResult = await _zanrProvider.get();
    print("glumacResult: ${glumacResult?.resultList.length}");
    print("zanrResult: ${zanrResult?.resultList.length}");
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen("Detalji", 
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
                    FormBuilderValidators.required(),
                    ]),
                    )
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: FormBuilderTextField(
                    name: "Cijena",
                    decoration: InputDecoration(labelText: "Cijena"),
                    validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                    ]),
                    )
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: FormBuilderTextField(
                    name: "Opis",
                    decoration: InputDecoration(labelText: "Opis"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
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
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
              SizedBox(width: 10,),  // Razmak između polja
              Expanded(
                child: FormBuilderTextField(
                  name: "Koreografija",
                  decoration: InputDecoration(labelText: "Koreografija"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
              SizedBox(width: 10,),  // Razmak između polja
              Expanded(
                child: FormBuilderTextField(
                  name: "Scenografija",
                  decoration: InputDecoration(labelText: "Scenografija"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
            ],),
            Row(
              children: [
                Expanded(
                  child: FormBuilderDropdown(
                    name: "zanrId",
                    validator: FormBuilderValidators.required(),
                    decoration: InputDecoration(labelText: "Zanr"),
                    items: zanrResult?.resultList.map((e) => DropdownMenuItem(child: Text(e.naziv ?? ""), value: e.zanrId)).toList() ?? [],
                  )
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: FormBuilderDropdown(
                    name: "glumacId",
                    validator: FormBuilderValidators.required(),
                    decoration: InputDecoration(labelText: "Glumac"),
                    items: glumacResult?.resultList.map((e) => DropdownMenuItem(child: Text('${e.ime ?? ""} ${e.prezime ?? ""}'), value: e.glumacId)).toList() ?? [],
                  )
                )
              ]
            ),
            Row(children: [
              Expanded(child: 
                FormBuilderDateTimePicker(
                  name: "TrajanjePocetak",
                  decoration: InputDecoration(labelText: "Trajanje početak"),
                  validator: FormBuilderValidators.required(),
                  inputType: InputType.date,
                  format: DateFormat("yyyy-MM-dd"),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(child: 
                FormBuilderDateTimePicker(
                  name: "TrajanjeKraj",
                  decoration: InputDecoration(labelText: "Trajanje kraj"),
                  validator: FormBuilderValidators.required(),
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
            _formKey.currentState?.saveAndValidate();
            final formData = _formKey.currentState!.value;

            final requestData = {
              ...formData,
              'TrajanjePocetak': DateFormat('yyyy-MM-dd').format(formData['TrajanjePocetak']),
              'TrajanjeKraj': DateFormat('yyyy-MM-dd').format(formData['TrajanjeKraj']),
              'Slika': _base64Image,
            };
            if(widget.predstava == null){
              _predstavaProvider.insert(requestData);
            } else {
              _predstavaProvider.update(widget.predstava!.predstavaId!, requestData);
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

