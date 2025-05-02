import 'package:eteatar_mobile/models/vijest.dart';
import 'package:eteatar_mobile/providers/auth_provider.dart';
import 'package:eteatar_mobile/providers/vijest_provider.dart';
import 'package:eteatar_mobile/screens/obavijesti_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class ObavijestiScreen extends StatefulWidget {
  ObavijestiScreen({super.key});

  @override
  State<ObavijestiScreen> createState() => _ObavijestiScreenState();
}

class _ObavijestiScreenState extends State<ObavijestiScreen> {

  bool _isLoading = true;
  late VijestProvider vijestProvider;
  List<Vijest> vijesti = [];

  @override
  void initState() {
    vijestProvider = context.read<VijestProvider>();
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      print("aaa ${AuthProvider.korisnikId}" );
      final vijestiResult = await vijestProvider.get(
          filter: {
          'korisnikId': AuthProvider.korisnikId,
          'isDeleted': false
          }
        );
      setState(() {
        vijesti = vijestiResult.resultList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Greška pri dohvatanju obavijesti!",
      );
    }
  }
  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Obavijesti'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : vijesti.isEmpty
              ? const Center(child: Text("Nema dostupnih obavijesti."))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: vijesti.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final vijest = vijesti[index];
                    return ListTile(
                      tileColor: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      leading: const Icon(Icons.message_outlined),
                      title: Text(vijest.naziv ?? 'Bez naziva'),
                      subtitle: Text(
                        vijest.datum != null
                            ? '${vijest.datum!.day}.${vijest.datum!.month}.${vijest.datum!.year}'
                            : '',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ObavijestDetailsScreen(vijest: vijest),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}