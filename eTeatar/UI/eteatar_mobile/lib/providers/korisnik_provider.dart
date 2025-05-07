import 'dart:convert';

import 'package:eteatar_mobile/models/korisnik.dart';
import 'package:eteatar_mobile/models/predstava.dart';
import 'package:eteatar_mobile/providers/auth_provider.dart';
import 'package:eteatar_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class KorisnikProvider extends BaseProvider<Korisnik> {
  KorisnikProvider() :super("Korisnik");

  @override
  Korisnik fromJson(data) {
    // TODO: implement fromJson
    return Korisnik.fromJson(data);
  }

  Future<Korisnik> login(String username, String password) async {
    var url = "${BaseProvider.baseUrl}Korisnik/Login?username=${username}&password=${password}";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response;
    try {
      response = await http.post(uri, headers: headers);
    } on Exception catch (e) {
      throw Exception("Greška prilikom prijave ${e.toString()}");
    }
    if (response.body == "") {
      throw Exception("Pogrešan username ili lozinka");
    }
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }
  Future<List<Predstava>> recommend() async {
    var url = "${BaseProvider.baseUrl}Korisnik/recommend?korisnikId=${AuthProvider.korisnikId}";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Predstava.fromJson(item)).toList();
      } else if (response.body.isEmpty) {
        throw Exception("Nema preporučenih predstava za korisnika.");
      } else {
        throw Exception("Greška prilikom dohvata preporuka: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Greška prilikom poziva API-a: ${e.toString()}");
    }
    
  }

 }