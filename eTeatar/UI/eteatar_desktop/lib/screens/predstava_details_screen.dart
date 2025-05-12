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
  SearchResult<Glumac>? glumacResult;
  SearchResult<Glumac>? initialGlumacResult;
  SearchResult<Zanr>? zanrResult;
  SearchResult<Zanr>? initialZanrResult ;

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
      "Trajanje" : widget.predstava?.trajanje.toString() ?? "",
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
                    decoration: const InputDecoration(labelText: "Naziv"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: "Obavezno polje"),
                      FormBuilderValidators.minLength(3, errorText: "Minimalna dužina je 3 karaktera!"),
                      FormBuilderValidators.maxLength(255, errorText: "Maksimalna dužina je 255 karaktera!"),
                    ]),
                    )
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: FormBuilderTextField(
                    name: "Cijena",
                    decoration:const InputDecoration(labelText: "Cijena"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: "Obavezno polje"),
                      FormBuilderValidators.numeric(errorText: "Unos mora biti broj!"),
                      FormBuilderValidators.max(10000, errorText: "Cijena ne smije biti veca od 10000 KM!"),
                      FormBuilderValidators.min(1, errorText: "Cijena ne smije biti manja od 1 KM"),
                    ]),
                    )
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: FormBuilderTextField(
                    name: "Trajanje",
                    decoration: const InputDecoration(labelText: "Trajanje (min)"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: "Obavezno polje"),
                      FormBuilderValidators.numeric(errorText: "Unos mora biti broj!"),
                      FormBuilderValidators.max(10000, errorText: "Trajanje ne smije biti veca od 600 min!"),
                      FormBuilderValidators.min(1, errorText: "Trajanje ne smije biti manja od 1 min"),
                    ]),
                    )
                ),
              ]
            ),
            Row(children: [
              Expanded(
                  child: FormBuilderTextField(
                    name: "Opis",
                    decoration: const InputDecoration(labelText: "Opis"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: "Obavezno polje"),
                      FormBuilderValidators.minLength(3, errorText: "Minimalna dužina je 3 karaktera!"),
                      FormBuilderValidators.maxLength(255, errorText: "Maksimalna dužina je 255 karaktera!"),
                    ]),
                  ),
                ),
            ],),
            Row(children: [
              Expanded(
                child: FormBuilderTextField(
                  name: "Produkcija",
                  decoration: const InputDecoration(labelText: "Produkcija"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    FormBuilderValidators.match(
                        r'^[A-ZČĆŽĐŠ][a-zA-ZčćžđšČĆŽĐŠ,]*$', 
                        errorText: "Prezime mora počinjati sa velikim slovom i smije sadržavati samo slova i zarez."),
                    FormBuilderValidators.minLength(3, errorText: "Minimalna dužina je 3 karaktera!"),
                    FormBuilderValidators.maxLength(255, errorText: "Maksimalna dužina je 255 karaktera!"),
                    
                  ]),
                ),
              ),
              const SizedBox(width: 10,),  // Razmak između polja
              Expanded(
                child: FormBuilderTextField(
                  name: "Koreografija",
                  decoration: const InputDecoration(labelText: "Koreografija"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    FormBuilderValidators.match(
                        r'^[A-ZČĆŽĐŠ][a-zA-ZčćžđšČĆŽĐŠ,]*$', 
                        errorText: "Prezime mora počinjati sa velikim slovom i smije sadržavati samo slova i zarez."),
                    FormBuilderValidators.minLength(3, errorText: "Minimalna dužina je 3 karaktera!"),
                    FormBuilderValidators.maxLength(255, errorText: "Maksimalna dužina je 255 karaktera!"),
                  ]),
                ),
              ),
              const SizedBox(width: 10,),  // Razmak između polja
              Expanded(
                child: FormBuilderTextField(
                  name: "Scenografija",
                  decoration: const InputDecoration(labelText: "Scenografija"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    FormBuilderValidators.match(
                        r'^[A-ZČĆŽĐŠ][a-zA-ZčćžđšČĆŽĐŠ,]*$', 
                        errorText: "Prezime mora počinjati sa velikim slovom i smije sadržavati samo slova i zarez."),
                    FormBuilderValidators.minLength(3, errorText: "Minimalna dužina je 3 karaktera!"),
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
                      title: const Text("Odaberi žanrove"),
                      selectedColor: Colors.blue,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      buttonText: const Text("Žanrovi"),
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
                const SizedBox(width: 10,),
                Expanded(
                  child: 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MultiSelectDialogField(
                      items: glumacResult?.resultList
                          .map((e) => MultiSelectItem<int>(e.glumacId!, "${e.ime} ${e.prezime}"))
                          .toList() ?? [],
                      initialValue: _selectedGlumci,
                      title: const Text("Odaberi glumce"),
                      selectedColor: Colors.blue,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      buttonText: const Text("Glumci"),
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
              Expanded(
                child: FormBuilderField(
                  name: "Slika",
                  builder: (field) {
                    return InputDecorator(decoration: 
                    const InputDecoration(
                      labelText: "Odaberite sliku"),
                      child: ListTile(
                        leading: const Icon(Icons.image),
                        title: const Text("Upload image"),
                        trailing: const Icon(Icons.file_upload),
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
                    text: "$e",
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

