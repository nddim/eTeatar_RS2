import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/hrana.dart';
import 'package:eteatar_desktop/providers/hrana_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

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
            _formKey.currentState?.saveAndValidate();
            final formData = _formKey.currentState!.value;

            final requestData = {
              ...formData,

            };
            if(widget.hrana == null){
              _hranaProvider.insert(requestData);
            } else {
              _hranaProvider.update(widget.hrana!.hranaId!, requestData);
            }
          }, 
          child: const Text("Sačuvaj")),
      ],),
    );
  }

}