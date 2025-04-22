import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/hrana.dart';
import 'package:eteatar_desktop/providers/hrana_provider.dart';
import 'package:eteatar_desktop/screens/hrana_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class HranaDetailsScreen extends StatefulWidget {
  Hrana? hrana;
  HranaDetailsScreen({super.key, this.hrana});

  @override
  State<HranaDetailsScreen> createState() => _HranaDetailsScreenState();
}

class _HranaDetailsScreenState extends State<HranaDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late HranaProvider _hranaProvider;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {

    _hranaProvider = context.read<HranaProvider>();

    super.initState();

    _initialValue = {
      "Naziv" : widget.hrana?.naziv ?? "",
      "Cijena" : widget.hrana?.cijena.toString() ?? "",
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
    return MasterScreen("Hrana detalji", 
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
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.max(10000, errorText: "Cijena ne smije biti veca od 10000 KM!"),
                      FormBuilderValidators.min(1, errorText: "Cijena ne smije biti manja od 1 KM"),
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
              if(widget.hrana == null) {
                try {
                  await _hranaProvider.insert(requestData);
                  QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: "Uspješno dodata hrana!",
                  width: 300,
                  onConfirmBtnTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HranaListScreen(),
                      ),
                    );
                  },
                );
                } catch (e){
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri dodavanju hrane!",
                    width: 300
                  );
                }

              } else {
                try {
                  await _hranaProvider.update(widget.hrana!.hranaId!, requestData);
                  QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: "Uspješno ažurirana hrana!",
                  width: 300,
                  onConfirmBtnTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HranaListScreen(),
                      ),
                    );
                  },
                );
                } catch (e){
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: "Greška pri ažuriranju hrane!",
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