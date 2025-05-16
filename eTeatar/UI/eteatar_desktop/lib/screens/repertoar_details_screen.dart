import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/predstava.dart';
import 'package:eteatar_desktop/models/repertoar.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/providers/predstava_provider.dart';
import 'package:eteatar_desktop/providers/repertoar_provider.dart';
import 'package:eteatar_desktop/screens/repertoar_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class RepertoarDetailsScreen extends StatefulWidget {
  final Repertoar? repertoar;
  const RepertoarDetailsScreen({super.key, this.repertoar});

  @override
  State<RepertoarDetailsScreen> createState() => _RepertoarDetailsScreenState();
}

class _RepertoarDetailsScreenState extends State<RepertoarDetailsScreen> {

  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  SearchResult<Predstava>? predstavaResult;
  SearchResult<Predstava>? initialPredstavaResult;
  late RepertoarProvider _repertoarProvider;
  late PredstavaProvider _predstavaProvider;
  bool isLoading = true;
  List<int> _selectedPredstave = [];


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {

    _repertoarProvider = context.read<RepertoarProvider>();
    _predstavaProvider = context.read<PredstavaProvider>();

    super.initState();

    _initialValue = {
      "Naziv" : widget.repertoar?.naziv ?? "",
      "Opis" : widget.repertoar?.opis ?? "",
      "DatumPocetka" : widget.repertoar?.datumPocetka ?? DateTime.now(),
      "DatumKraja" : widget.repertoar?.datumKraja ?? DateTime.now(),
      
    };

    initForm();
  }

  Future initForm() async {
    try {
      predstavaResult = await _predstavaProvider.get(filter: { 'isDeleted': false});
    } catch (e){
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju predstava!",
        text: "$e",
        width: 300
      );
    }

    if(widget.repertoar != null){
      try {
        initialPredstavaResult = await _predstavaProvider.get(filter: { "repertoarId" : widget.repertoar!.repertoarId, 'isDeleted': false});
        if (initialPredstavaResult != null) {
          _selectedPredstave = initialPredstavaResult!.resultList.map((e) => e.predstavaId!).toList();
        }
      } catch (e){
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Greška pri dohvatanju glumaca!",
          text: "$e",
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
    return MasterScreen("Repertoar detalji", 
      Column(children: [
        isLoading ? Container() : _buildForm(), _save(),
      ],)
    ) ;
  }

  final DateTime _maxDate = DateTime.now().add(const Duration(days: 365));
  DateTime? _selectedDatumPocetka;

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
                      FormBuilderValidators.minLength(3, errorText: "Minimalna dužina je 3 karaktera!"),
                      FormBuilderValidators.maxLength(255, errorText: "Maksimalna dužina je 255 karaktera!"),
                    ]),
                    )
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: FormBuilderTextField(
                    name: "Opis",
                    decoration: InputDecoration(labelText: "Opis"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: "Obavezno polje"),
                      FormBuilderValidators.minLength(3, errorText: "Minimalna dužina je 3 karaktera!"),
                      FormBuilderValidators.maxLength(255, errorText: "Maksimalna dužina je 255 karaktera!"),
                    ]),
                    )
                ),
              ]
            ),
            Row(children: [
              Expanded(
                child: FormBuilderDateTimePicker(
                  name: "DatumPocetka",
                  decoration: InputDecoration(labelText: "Datum pocetka"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    (value) {
                      if (value == null) return null;
                      if (value.isBefore(DateTime.now())) {
                        return "Ne možete izabrati datum u prošlosti!";
                      }
                      return null;
                    }
                  ]),
                  inputType: InputType.date,
                  format: DateFormat("yyyy-MM-dd"),
                  firstDate: DateTime.now(), 
                  lastDate: _maxDate,        
                  onChanged: (pocetniDatum) {
                    setState(() {
                      _selectedDatumPocetka = pocetniDatum;
                      var datumKraja = _formKey.currentState?.fields["DatumKraja"]?.value;
                      if (datumKraja != null && pocetniDatum != null && datumKraja.isBefore(pocetniDatum)) {
                        _formKey.currentState?.fields["DatumKraja"]?.didChange(null);
                      }
                    });
                  },
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: FormBuilderDateTimePicker(
                  name: "DatumKraja",
                  decoration: InputDecoration(labelText: "Datum kraja"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    (value) {
                      if (value == null) return null;
                      final datumPocetka = _formKey.currentState?.fields["DatumPocetka"]?.value;
                      if (datumPocetka != null && value.isBefore(datumPocetka)) {
                        return "Datum kraja ne može biti prije datuma početka!";
                      }
                      if (value.isBefore(DateTime.now())) {
                        return "Ne možete izabrati datum u prošlosti!";
                      }
                      return null;
                    }
                  ]),
                  inputType: InputType.date,
                  format: DateFormat("yyyy-MM-dd"),
                  firstDate: _selectedDatumPocetka ?? DateTime.now(),
                  lastDate: _maxDate,
                ),
              ),
            ],
            ),
            Row(
              children: [
                Expanded(
                  child: 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MultiSelectDialogField<int>(
                      items: predstavaResult?.resultList
                          .map((e) => MultiSelectItem<int>(e.predstavaId!, e.naziv ?? ""))
                          .toList() ?? [],
                      initialValue: _selectedPredstave,
                      title: Text("Odaberi predstave"),
                      selectedColor: Colors.blue,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      buttonText: Text("Predstave"),
                      onConfirm: (values) {
                        _selectedPredstave = values.cast<int>();
                      },
                      validator: (values) {
                        if (values == null || values.isEmpty) {
                          return "Odaberite barem jednu predstavu";
                        }
                        return null;
                      },
                    ),
                  )
                ),
              ]
            )
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
                'DatumPocetka': DateFormat('yyyy-MM-dd').format(formData['DatumPocetka']),
                'DatumKraja': DateFormat('yyyy-MM-dd').format(formData['DatumKraja']),
                'Predstave': _selectedPredstave,
              };
              if(widget.repertoar == null){
                try {
                  await _repertoarProvider.insert(requestData);
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: "Uspješno dodan repertoar!",
                    width: 300,
                    onConfirmBtnTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RepertoarListScreen(),
                        ),
                      );
                    },
                  );
                } catch (e){
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri dodavanju repertoara!",
                    text: "$e",
                    width: 300
                  );
                }
              } else {
                try {
                  await _repertoarProvider.update(widget.repertoar!.repertoarId!, requestData);
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: "Uspješno ažuriran repertoar!",
                    width: 300,
                    onConfirmBtnTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RepertoarListScreen(),
                        ),
                      );
                    },
                  );
                } catch (e){
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri ažuriranju repertoara!",
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

}