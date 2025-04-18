import 'package:eteatar_desktop/providers/auth_provider.dart';
import 'package:eteatar_desktop/providers/predstava_provider.dart';
import 'package:eteatar_desktop/screens/predstava_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => PredstavaProvider()),

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue, primary: Colors.red),
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

  @override Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar( title: const Text('Login'),),
      body:  Center(
        child: Center(
          child:Container(constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
          child:Card(
            child:Column(
              children: [
                Image.asset("assets/images/logo.png", height: 100, width: 100,),
                SizedBox(height: 10,),
                TextField(controller: _usernameController,decoration: InputDecoration(labelText: "Username", prefixIcon: Icon(Icons.person)),),
                SizedBox(height: 10,),
                TextField(controller : _passwordController, decoration: InputDecoration(labelText: "Password", prefixIcon: Icon(Icons.lock)),),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: () async {
                  print("credentials: ${_usernameController.text} ${_passwordController.text}");
                  PredstavaProvider predstavaProvider = PredstavaProvider();
                  AuthProvider.username = _usernameController.text;
                  AuthProvider.password = _passwordController.text;
                  try{
                    var data = await predstavaProvider.get();
                    Navigator.of(context).push(MaterialPageRoute(builder: (builder) => PredstavaListScreen()));

                  } on Exception catch (e) {
                    showDialog(context: context, builder: (context) => AlertDialog(title: const Text("Error"), 
                      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Ok"))], content: Text(e.toString()),));
                  }
                }, child: const Text("Login"),),
                ],
              )
          ),
          ),
        ),
        ),
    );
  }
}
