import 'dart:convert';

import 'package:eteatar_desktop/models/rezervacija.dart';
import 'package:eteatar_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class RezervacijaProvider extends BaseProvider<Rezervacija> {
  RezervacijaProvider() :super("Rezervacija");

  @override
  Rezervacija fromJson(data) {
    // TODO: implement fromJson
    return Rezervacija.fromJson(data);
  }

  Future<Rezervacija> odobri(int rezervacijaId) async {
    var url = "${BaseProvider.baseUrl}Rezervacija/$rezervacijaId/odobri";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response;
    try {
      response = await http.put(uri, headers: headers);
    } on Exception catch (e) {
      throw Exception("Greška prilikom završavanja rezervacije: $e");
    }

    if (isValidResponse(response)) {
      var obj = jsonDecode(response.body);

      if (obj is Map<String, dynamic>) {
        return Rezervacija.fromJson(obj);
      } else {
        throw Exception("Očekivana rezervacija iz JSON odgovora.");
      }
    }

    throw Exception("Greška: Nevažeći odgovor od servera.");

    }

  Future<Rezervacija> ponisti(int rezervacijaId) async {
    var url = "${BaseProvider.baseUrl}Rezervacija/$rezervacijaId/ponisti";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response;
    try {
      response = await http.put(uri, headers: headers);
    } on Exception catch (e) {
      throw Exception("Greška prilikom završavanja rezervacije: $e");
    }

    if (isValidResponse(response)) {
      var obj = jsonDecode(response.body);

      if (obj is Map<String, dynamic>) {
        return Rezervacija.fromJson(obj);
      } else {
        throw Exception("Očekivana rezervacija iz JSON odgovora.");
      }
    }
    
    throw Exception("Greška: Nevažeći odgovor od servera.");
  }
 }