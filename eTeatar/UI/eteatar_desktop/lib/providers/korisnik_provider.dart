import 'dart:convert';

import 'package:eteatar_desktop/models/korisnik.dart';
import 'package:eteatar_desktop/providers/auth_provider.dart';
import 'package:eteatar_desktop/providers/base_provider.dart';
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
      AuthProvider.username = fromJson(data).korisnickoIme;
      AuthProvider.password = password;
      AuthProvider.korisnikId = fromJson(data).korisnikId;

      for (var item in fromJson(data).korisnikUlogas) {
        if (item.uloga!.naziv == "Admin") {
          break;
        } else {
          throw Exception(
              "Ne možete pristupiti interfejsu gledaoca putem desktop aplikacije");
        }
      }
      return fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }
 }