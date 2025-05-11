import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/glumac.dart';
import 'package:eteatar_desktop/providers/glumac_provider.dart';
import 'package:eteatar_desktop/screens/glumac_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
class GlumacDetailsScreen extends StatefulWidget {
  final Glumac? glumac;
  const GlumacDetailsScreen({super.key, this.glumac});

  @override
  State<GlumacDetailsScreen> createState() => _GlumacDetailsScreenState();
}

class _GlumacDetailsScreenState extends State<GlumacDetailsScreen> {

  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late GlumacProvider _glumacProvider;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

   @override
  void initState() {

    _glumacProvider = context.read<GlumacProvider>();

    super.initState();

    _initialValue = {
      "Ime" : widget.glumac?.ime ?? "",
      "Prezime" : widget.glumac?.prezime ?? "",
      "Biografija" : widget.glumac?.biografija ?? "",
      
    };

    initForm();
  }

  Future initForm() async {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen("Glumci detalji", 
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
                      FormBuilderValidators.maxLength(255, errorText: "Maksimalna dužina je 255 karaktera!"),
                    ]),
                    )
                ),
              ]
            ),
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: "Biografija",
                    decoration: InputDecoration(labelText: "Biografija"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: "Obavezno polje"),
                      FormBuilderValidators.maxLength(500, errorText: "Maksimalna dužina je 500 karaktera!"),
                    ]),
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

              };
              if(widget.glumac == null){
                try {
                await _glumacProvider.insert(requestData);
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: "Uspješno dodan glumac!",
                  width: 300,
                  onConfirmBtnTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const GlumacListScreen(),
                      ),
                    );
                  },
                );
                } catch (e){
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri kreiranju glumca!",
                    text: "$e",
                    width: 300);
                }
              } else {
                try {
                await _glumacProvider.update(widget.glumac!.glumacId!, requestData);
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: "Uspješno ažuriran glumac!",
                  width: 300,
                  onConfirmBtnTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const GlumacListScreen(),
                      ),
                    );
                  },
                );
                } catch (e){
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri ažuriranju glumca!",
                    text: "$e",
                    width: 300);
                }
              }
            }
            
          }, 
          child: const Text("Sačuvaj")),
      ],),
    );
  }

}