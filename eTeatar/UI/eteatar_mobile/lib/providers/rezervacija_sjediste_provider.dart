import 'dart:convert';

import 'package:eteatar_mobile/models/rezervacija_sjediste.dart';
import 'package:eteatar_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class RezervacijaSjedisteProvider extends BaseProvider<RezervacijaSjediste> {
  RezervacijaSjedisteProvider() :super("Rezervacija");

  @override
  RezervacijaSjediste fromJson(data) {
    // TODO: implement fromJson
    return RezervacijaSjediste.fromJson(data);
  }

  Future<List<int>> getZauzetaSjedista(int terminId) async {
    var url = "${BaseProvider.baseUrl}RezervacijaSjediste/GetRezervisanaSjedistaByTermin/$terminId";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    try {
      final response = await http.get(uri, headers: headers);
      if (isValidResponse(response)) {
        final List<dynamic> obj = jsonDecode(response.body);
        return obj.map((e) => e as int).toList();
      } else {
        throw Exception("Greška na serveru");
      }
    } catch (e) {
      throw Exception("Greška prilikom dohvatanja zauzetih sjedišta: $e");
    }
  }
}