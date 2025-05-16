import 'package:eteatar_desktop/models/korisnik.dart';
import 'package:eteatar_desktop/providers/auth_provider.dart';
import 'package:eteatar_desktop/providers/dvorana_provider.dart';
import 'package:eteatar_desktop/providers/glumac_provider.dart';
import 'package:eteatar_desktop/providers/karta_provider.dart';
import 'package:eteatar_desktop/providers/korisnik_provider.dart';
import 'package:eteatar_desktop/providers/ocjena_provider.dart';
import 'package:eteatar_desktop/providers/predstava_provider.dart';
import 'package:eteatar_desktop/providers/repertoar_provider.dart';
import 'package:eteatar_desktop/providers/rezervacija_provider.dart';
import 'package:eteatar_desktop/providers/sjediste_provider.dart';
import 'package:eteatar_desktop/providers/stavka_uplate_provider.dart';
import 'package:eteatar_desktop/providers/termin_provider.dart';
import 'package:eteatar_desktop/providers/uloga_provider.dart';
import 'package:eteatar_desktop/providers/uplata_provider.dart';
import 'package:eteatar_desktop/providers/vijest_provider.dart';
import 'package:eteatar_desktop/providers/zanr_provider.dart';
import 'package:eteatar_desktop/screens/predstava_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

void main() {
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
  ], child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        title: const Text('Dobrodošli u eTeatar'),
        backgroundColor: const Color.fromRGBO(72, 142, 255, 1),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 450, maxWidth: 400),
          child: Card(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/logo.png", height: 100, width: 100),
                    const SizedBox(height: 20),
                    const Text('Dobrodošli u eTeatar'),
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
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          PredstavaProvider predstavaProvider = PredstavaProvider();
                          AuthProvider.username = _usernameController.text;
                          AuthProvider.password = _passwordController.text;
                          try {
                            KorisnikProvider korisnikProvider = KorisnikProvider();
                            Korisnik korisnik = await korisnikProvider.login(AuthProvider.username!, AuthProvider.password!);
                            AuthProvider.korisnikId = korisnik.korisnikId;
                            AuthProvider.ime = korisnik.ime;
                            AuthProvider.prezime = korisnik.prezime;
                            AuthProvider.telefon = korisnik.telefon;
                            AuthProvider.email = korisnik.email;
                            AuthProvider.slika = korisnik.slika;
                            await predstavaProvider.get();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (builder) => PredstavaListScreen()));
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
