import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/predstava.dart';
import 'package:eteatar_desktop/models/repertoar.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/providers/predstava_provider.dart';
import 'package:eteatar_desktop/providers/repertoar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class RepertoarDetailsScreen extends StatefulWidget {
  Repertoar? repertoar;
  RepertoarDetailsScreen({super.key, this.repertoar});

  @override
  State<RepertoarDetailsScreen> createState() => _RepertoarDetailsScreenState();
}

class _RepertoarDetailsScreenState extends State<RepertoarDetailsScreen> {

  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  SearchResult<Predstava>? predstavaResult = null;
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
      predstavaResult = await _predstavaProvider.get();
    } catch (e){
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju predstava!",
        width: 300
      );
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
                    name: "Opis",
                    decoration: InputDecoration(labelText: "Opis"),
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
                  name: "DatumPocetka",
                  decoration: InputDecoration(labelText: "Datum pocetka"),
                  validator: FormBuilderValidators.required(),
                  inputType: InputType.date,
                  format: DateFormat("yyyy-MM-dd"),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(child: 
                FormBuilderDateTimePicker(
                  name: "DatumKraja",
                  decoration: InputDecoration(labelText: "Datum kraja"),
                  validator: FormBuilderValidators.required(),
                  inputType: InputType.date,
                  format: DateFormat("yyyy-MM-dd"),
                ),
              )
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
            _formKey.currentState?.saveAndValidate();
            final formData = _formKey.currentState!.value;

            final requestData = {
              ...formData,
              'DatumPocetka': DateFormat('yyyy-MM-dd').format(formData['DatumPocetka']),
              'DatumKraja': DateFormat('yyyy-MM-dd').format(formData['DatumKraja']),
              'Predstave': _selectedPredstave,
            };
            if(widget.repertoar == null){
              try {
                _repertoarProvider.insert(requestData);
              } catch (e){
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: "Greška pri dodavanju repertoara!",
                  width: 300
                );
              }
            } else {
              try {
                _repertoarProvider.update(widget.repertoar!.repertoarId!, requestData);
              } catch (e){
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: "Greška pri ažuriranju repertoara!",
                  width: 300
                );
              }
            }
          }, 
          child: const Text("Sačuvaj")),
      ],),
    );
  }

}