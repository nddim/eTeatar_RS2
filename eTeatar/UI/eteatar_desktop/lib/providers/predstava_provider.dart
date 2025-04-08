import 'dart:convert';
import 'package:eteatar_desktop/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
class PredstavaProvider {
  static String? _baseUrl;
  PredstavaProvider () {
    _baseUrl = const String.fromEnvironment("baseUrl", defaultValue: "https://localhost:7219/");
  }

  Future<dynamic> get() async {
    var url = "${_baseUrl}Predstava";
    var uri = Uri.parse(url);
    print("url:::::::: $url");
    var response  = await http.get(uri, headers: createHeaders());
    

    if (isValidResponse(response)){
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Invalid response");
    }
  }

  Map<String, String> createHeaders(){
    String username = AuthProvider.username!;
    String password = AuthProvider.password!;

    String basicAuth = "Basic ${base64Encode(utf8.encode("$username:$password"))}";

    var headers = {
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };

    return headers;
  }

  bool isValidResponse(http.Response response){
    if(response.statusCode < 299){
      return true;
    } else if (response.statusCode == 401){
      throw Exception("Unauthorized");
    } 
    else {
      throw Exception("Invalid response");
    }
  }
 }