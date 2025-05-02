import 'package:eteatar_mobile/models/uplata.dart';
import 'package:eteatar_mobile/providers/auth_provider.dart';
import 'package:eteatar_mobile/providers/uplata_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class UplateScreen extends StatefulWidget {
  const UplateScreen({super.key});

  @override
  State<UplateScreen> createState() => _UplateScreenState();
}

class _UplateScreenState extends State<UplateScreen> {
  bool _isLoading = true;
  List<Uplata> uplate = [];
  late UplataProvider uplataProvider;

  @override
  void initState() {
    super.initState();
    uplataProvider = context.read<UplataProvider>();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final result = await uplataProvider.get(
        filter: {
          'korisnikId': AuthProvider.korisnikId,
          'isDeleted': false
          }
      );

      setState(() {
        uplate = result.resultList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Greška pri dohvatanju uplata!',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moje Uplate'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : uplate.isEmpty
                ? const Center(child: Text('Nemate evidentiranih uplata.'))
                : ListView.builder(
                    itemCount: uplate.length,
                    itemBuilder: (context, index) {
                      final uplata = uplate[index];
                      final datum = uplata.datum != null
                          ? "${uplata.datum!.day}.${uplata.datum!.month}.${uplata.datum!.year}"
                          : "Nepoznat datum";

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text('Uplata - ${uplata.iznos} KM'),
                          subtitle: Text(datum),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}