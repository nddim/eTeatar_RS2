import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/dvorana.dart';
import 'package:eteatar_desktop/providers/dvorana_provider.dart';
import 'package:eteatar_desktop/screens/dvorana_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class DvoranaDetailsScreen extends StatefulWidget {
  final Dvorana? dvorana;
  const DvoranaDetailsScreen({super.key, this.dvorana});

  @override
  State<DvoranaDetailsScreen> createState() => _DvoranaDetailsScreenState();
}

class _DvoranaDetailsScreenState extends State<DvoranaDetailsScreen> {

  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late DvoranaProvider _dvoranaProvider;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {

    _dvoranaProvider = context.read<DvoranaProvider>();

    super.initState();

    _initialValue = {
      "Naziv" : widget.dvorana?.naziv ?? "",
      "Kapacitet" : widget.dvorana?.kapacitet.toString() ?? "",
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
    return MasterScreen("Dvorana detalji", 
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
                    name: "Kapacitet",
                    decoration: InputDecoration(labelText: "Kapacitet"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: "Obavezno polje"),
                      FormBuilderValidators.numeric(errorText: "Unos mora biti broj!"),
                      FormBuilderValidators.max(100, errorText: "Kapacitet ne smije biti veci od 100!"),
                      FormBuilderValidators.min(5, errorText: "Kapacitet ne smije biti manj od 5!"),
                    ]),
                    )
                ),
              ]
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

              };
              if(widget.dvorana == null){
              try {
                await _dvoranaProvider.insert(requestData);
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: "Uspješno dodata dvorana!",
                  width: 300,
                  onConfirmBtnTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DvoranaListScreen(),
                      ),
                    );
                  },
                );
              } catch (e){
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: "Greška pri kreiranju dvorane!",
                  width: 300);
              }
              } else {
              try {
                await _dvoranaProvider.update(widget.dvorana!.dvoranaId!, requestData);
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: "Uspješno ažurirana dvorana!",
                  width: 300,
                  onConfirmBtnTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DvoranaListScreen(),
                      ),
                    );
                  },
                );
              } catch (e){
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: "Greška pri azuriranju dvorane!",
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