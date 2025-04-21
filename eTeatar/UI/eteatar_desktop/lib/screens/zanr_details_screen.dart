import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/zanr.dart';
import 'package:eteatar_desktop/providers/zanr_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class ZanrDetailsScreen extends StatefulWidget {
  Zanr? zanr;
  ZanrDetailsScreen({super.key, this.zanr});

  @override
  State<ZanrDetailsScreen> createState() => _ZanrDetailsScreenState();
}

class _ZanrDetailsScreenState extends State<ZanrDetailsScreen> {

  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late ZanrProvider _zanrProvider;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  
  @override
  void initState() {

    _zanrProvider = context.read<ZanrProvider>();

    super.initState();

    _initialValue = {
      "Naziv" : widget.zanr?.naziv ?? "",
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
    return MasterScreen("Zanr detalji", 
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
            if(widget.zanr == null){
              _zanrProvider.insert(requestData);
            } else {
              _zanrProvider.update(widget.zanr!.zanrId!, requestData);
            }
          }, 
          child: const Text("Sačuvaj")),
      ],),
    );
  }

}