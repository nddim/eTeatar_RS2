import 'package:eteatar_desktop/layouts/master_screen.dart';
import 'package:eteatar_desktop/models/korisnik.dart';
import 'package:eteatar_desktop/models/search_result.dart';
import 'package:eteatar_desktop/models/vijest.dart';
import 'package:eteatar_desktop/providers/korisnik_provider.dart';
import 'package:eteatar_desktop/providers/vijest_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class VijestDetailsScreen extends StatefulWidget {
  Vijest? vijest;
  VijestDetailsScreen({super.key, this.vijest});

  @override
  State<VijestDetailsScreen> createState() => _VijestDetailsScreenState();
}

class _VijestDetailsScreenState extends State<VijestDetailsScreen> {

  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late VijestProvider _vijestProvider;
  late KorisnikProvider _korisnikProvider;
  bool isLoading = true;
  SearchResult<Korisnik>? korisnikResult = null;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

   @override
  void initState() {
    _vijestProvider = context.read<VijestProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();

    super.initState();

    _initialValue = {
      "Naziv" : widget.vijest?.naziv ?? "",
      "Sadrzaj" : widget.vijest?.sadrzaj ?? "",
      "KorisnikId" : widget.vijest?.korisnikId.toString() ?? "",
    };

    initForm();
  }

  Future initForm() async {
    try {
      korisnikResult = await _korisnikProvider.get();
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju korisnika!",
        width: 300
      );
    }
    setState(() {
      isLoading = false;
    });
  }

   @override
  Widget build(BuildContext context) {
    return MasterScreen("Vijest detalji", 
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
                  child: FormBuilderDropdown(
                     name: "korisnikId",
                     validator: FormBuilderValidators.required(),
                     decoration: InputDecoration(labelText: "Korisnik"),
                     items: korisnikResult?.resultList.map((e) => DropdownMenuItem(child: Text(e.ime ?? ""), value: e.korisnikId)).toList() ?? [],
                )
                ),
              ]
            ),
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: "Sadrzaj",
                    decoration: InputDecoration(labelText: "Sadrzaj"),
                    validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    ]),
                    )
                ),
              ],
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

            };
            if(widget.vijest == null){
              try {
                _vijestProvider.insert(requestData);
              } catch (e){
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: "Greška pri dodavanju vijesti!",
                  width: 300
                );
              }
            } else {
              try {
                _vijestProvider.update(widget.vijest!.vijestId!, requestData);
              } catch (e){
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: "Greška pri ažuriranju vijesti!",
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