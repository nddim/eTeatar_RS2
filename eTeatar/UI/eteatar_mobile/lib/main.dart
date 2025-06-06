import 'dart:async';

import 'package:eteatar_mobile/layouts/master_screen.dart';
import 'package:eteatar_mobile/models/korisnik.dart';
import 'package:eteatar_mobile/providers/auth_provider.dart';
import 'package:eteatar_mobile/providers/dvorana_provider.dart';
import 'package:eteatar_mobile/providers/glumac_provider.dart';
import 'package:eteatar_mobile/providers/karta_dto_provider.dart';
import 'package:eteatar_mobile/providers/karta_provider.dart';
import 'package:eteatar_mobile/providers/korisnik_provider.dart';
import 'package:eteatar_mobile/providers/ocjena_provider.dart';
import 'package:eteatar_mobile/providers/predstava_provider.dart';
import 'package:eteatar_mobile/providers/repertoar_provider.dart';
import 'package:eteatar_mobile/providers/rezervacija_provider.dart';
import 'package:eteatar_mobile/providers/rezervacija_sjediste_provider.dart';
import 'package:eteatar_mobile/providers/sjediste_provider.dart';
import 'package:eteatar_mobile/providers/stavka_uplate_provider.dart';
import 'package:eteatar_mobile/providers/termin_provider.dart';
import 'package:eteatar_mobile/providers/uloga_provider.dart';
import 'package:eteatar_mobile/providers/uplata_provider.dart';
import 'package:eteatar_mobile/providers/vijest_provider.dart';
import 'package:eteatar_mobile/providers/zanr_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (FlutterErrorDetails errorDetails) {
      print("ON error error: ${errorDetails.exception.toString()}");
    };
    await dotenv.load(fileName: ".env");
    runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => DvoranaProvider()),
    ChangeNotifierProvider(create: (_) => GlumacProvider()),
    ChangeNotifierProvider(create: (_) => KartaProvider()),
    ChangeNotifierProvider(create: (_) => KorisnikProvider()),
    ChangeNotifierProvider(create: (_) => OcjenaProvider()),
    ChangeNotifierProvider(create: (_) => PredstavaProvider()),
    ChangeNotifierProvider(create: (_) => RepertoarProvider()),
    ChangeNotifierProvider(create: (_) => RezervacijaProvider()),
    ChangeNotifierProvider(create: (_) => SjedisteProvider()),
    ChangeNotifierProvider(create: (_) => StavkaUplateProvider()),
    ChangeNotifierProvider(create: (_) => TerminProvider()),
    ChangeNotifierProvider(create: (_) => UlogaProvider()),
    ChangeNotifierProvider(create: (_) => UplataProvider()),
    ChangeNotifierProvider(create: (_) => VijestProvider()),
    ChangeNotifierProvider(create: (_) => ZanrProvider()),
    ChangeNotifierProvider(create: (_) => RezervacijaSjedisteProvider()),
    ChangeNotifierProvider(create: (_) => KartaDtoProvider()),
  ], child: const MyApp(),));
  }, (error, stack) {
    print("Error from OUT_SIDE Framerwork");
    print("--------------------------------");
    print("Error : $error");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        dataTableTheme: DataTableThemeData(
          headingRowColor:
              MaterialStateColor.resolveWith((states) => const Color.fromRGBO(72, 142, 255, 1)),
          headingTextStyle: const TextStyle(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(72, 142, 255, 1), primary: const Color.fromRGBO(72, 142, 255, 1)),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('eTeatar'),
        backgroundColor: const Color.fromARGB(255, 44, 188, 255),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/images/logo.png", height: 100, width: 100),
                      const SizedBox(height: 20),
                      const Text(
                        'Dobrodošli u eTeatar',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _usernameController,
                        maxLength: 30,
                        decoration: const InputDecoration(
                          labelText: "Korisničko ime",
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Unesite korisničko ime';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        maxLength: 30,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          hintText: '********',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Unesite lozinku';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              PredstavaProvider predstavaProvider = PredstavaProvider();
                              AuthProvider.username = _usernameController.text;
                              AuthProvider.password = _passwordController.text;
                              try {
                                KorisnikProvider korisnikProvider = KorisnikProvider();
                                Korisnik korisnik = await korisnikProvider.login(
                                  AuthProvider.username!,
                                  AuthProvider.password!,
                                );
                                AuthProvider.korisnikId = korisnik.korisnikId;
                                AuthProvider.ime = korisnik.ime;
                                AuthProvider.prezime = korisnik.prezime;
                                AuthProvider.telefon = korisnik.telefon;
                                AuthProvider.email = korisnik.email;
                                AuthProvider.slika = korisnik.slika;
                                await predstavaProvider.get();

                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => const MasterScreen()),
                                );
                              } on Exception catch (e) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  title: "Pogrešni kredencijali za login!",
                                  text: "$e",
                                  width: 250,
                                );
                              }
                            }
                          },
                          child: const Text("Login"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}