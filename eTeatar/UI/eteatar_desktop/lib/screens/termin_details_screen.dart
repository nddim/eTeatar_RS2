import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/dvorana.dart';
import 'package:eteatar_desktop/models/predstava.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/termin.dart';
import 'package:eteatar_desktop/providers/dvorana_provider.dart';
import 'package:eteatar_desktop/providers/predstava_provider.dart';
import 'package:eteatar_desktop/providers/termin_provider.dart';
import 'package:eteatar_desktop/screens/termin_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class TerminDetailsScreen extends StatefulWidget {
  Termin? termin;
  TerminDetailsScreen({super.key, this.termin});

  @override
  State<TerminDetailsScreen> createState() => _TerminDetailsScreenState();
}

class _TerminDetailsScreenState extends State<TerminDetailsScreen> {

  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late TerminProvider _terminProvider;
  late PredstavaProvider _predstavaProvider;
  late DvoranaProvider _dvoranaProvider;
  SearchResult<Predstava>? predstavaResult = null;
  SearchResult<Dvorana>? dvoranaResult = null;
  bool isLoading = true;
  List<int> _selectedPredstave = [];
  List<int> _selectedDvorane = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {

    _terminProvider = context.read<TerminProvider>();
    _predstavaProvider = context.read<PredstavaProvider>();
    _dvoranaProvider = context.read<DvoranaProvider>();

    super.initState();

    _initialValue = {
      "Datum" : widget.termin?.datum ?? DateTime.now(),
      "Status" : widget.termin?.status.toString() ?? "",
      "DvoranaId" : widget.termin?.dvoranaId.toString() ?? "",
      "PredstavaId" : widget.termin?.predstavaId.toString() ?? "",
    };

    initForm();
  }

  Future initForm() async {
    try {
      predstavaResult = await _predstavaProvider.get(filter: { 'isDeleted': false});
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju predstava!",
        width: 300
      );
    }
    try {
      dvoranaResult = await _dvoranaProvider.get(filter: { 'isDeleted': false});
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju dvorana!",
        width: 300
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen("Termini detalji", 
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
                Expanded(child: 
                FormBuilderDateTimePicker(
                  name: "Datum",
                  decoration: InputDecoration(labelText: "Datum"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                  ]),
                  inputType: InputType.both,
                  format: DateFormat("yyyy-MM-dd"),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: FormBuilderTextField(
                  name: "Status",
                  decoration: InputDecoration(labelText: "Status"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obavezno polje"),
                    FormBuilderValidators.maxLength(255, errorText: "Maksimalna dužina je 255 karaktera!"),
                  ]),
                  )
              ),
              ]
            ),
            Row(
              children: [
                Expanded(
                  child: FormBuilderDropdown(
                     name: "predstavaId",
                     validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: "Obavezno polje"),
                    ]),
                     decoration: InputDecoration(labelText: "Predstava"),
                     items: predstavaResult?.resultList.map((e) => DropdownMenuItem(child: Text(e.naziv ?? ""), value: e.predstavaId)).toList() ?? [],
                )
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: FormBuilderDropdown(
                     name: "dvoranaId",
                     validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: "Obavezno polje"),
                    ]),
                     decoration: InputDecoration(labelText: "Dvorana"),
                     items: dvoranaResult?.resultList.map((e) => DropdownMenuItem(child: Text(e.naziv ?? ""), value: e.dvoranaId)).toList() ?? [],
                )
                ),
              ],
            ),
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
                'Datum': DateFormat('yyyy-MM-dd').format(formData['Datum']),
              };
              if(widget.termin == null){
                try {
                  await _terminProvider.insert(requestData);
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: "Uspješno dodan termin!",
                    width: 300,
                    onConfirmBtnTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TerminListScreen(),
                        ),
                      );
                    },
                  );
                } catch (e){
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri dodavanju termina!",
                    width: 300
                  );
                }
              } else {
                try {
                  await _terminProvider.update(widget.termin!.terminId!, requestData);
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: "Uspješno ažuriran termin!",
                    width: 300,
                    onConfirmBtnTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TerminListScreen(),
                        ),
                      );
                    },
                  );
                } catch (e){
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri ažuriranju termina!",
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