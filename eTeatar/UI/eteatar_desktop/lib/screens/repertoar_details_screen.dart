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

  final DateTime _maxDate = DateTime.now().add(const Duration(days: 365 * 2));

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormBuilderField<DateTime>(
                        name: "DatumPocetka",
                        builder: (field) => const SizedBox.shrink(),
                      ),
                      FormBuilderField<DateTime>(
                        name: "DatumKraja",
                        builder: (field) => const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 10),
                      InputDecorator(
                        decoration: const InputDecoration(
                          labelText: "Odaberi period repertoara",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(Icons.date_range),
                              label: const Text("Odaberi datum početka i kraja"),
                              onPressed: () async {
                                final selectedStart = _formKey.currentState?.fields['DatumPocetka']?.value ?? DateTime.now();
                                final selectedEnd = _formKey.currentState?.fields['DatumKraja']?.value ?? DateTime.now().add(const Duration(days: 1));

                                final DateTimeRange? picked = await showDateRangePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  lastDate: _maxDate,
                                  initialDateRange: DateTimeRange(start: selectedStart, end: selectedEnd),
                                );

                                if (picked != null) {
                                  _formKey.currentState?.fields['DatumPocetka']?.didChange(picked.start);
                                  _formKey.currentState?.fields['DatumKraja']?.didChange(picked.end);
                                  setState(() {});
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            Builder(builder: (context) {
                              final start = _formKey.currentState?.fields['DatumPocetka']?.value;
                              final end = _formKey.currentState?.fields['DatumKraja']?.value;
                              if (start == null || end == null) {
                                return const Text("Nije odabran period.");
                              }
                              return Text(
                                "Odabrano: ${DateFormat('yyyy-MM-dd').format(start)} do ${DateFormat('yyyy-MM-dd').format(end)}",
                                style: TextStyle(color: Colors.grey[700]),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 28.0), // radi poravnanja s gornjim dugmetom
                    child: MultiSelectDialogField<int>(
                      items: predstavaResult?.resultList
                              .map((e) => MultiSelectItem<int>(e.predstavaId!, e.naziv ?? ""))
                              .toList() ??
                          [],
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
                  ),
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