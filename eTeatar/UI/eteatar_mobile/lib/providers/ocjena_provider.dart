import 'dart:convert';

import 'package:eteatar_mobile/models/ocjena.dart';
import 'package:eteatar_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class OcjenaProvider extends BaseProvider<Ocjena> {
  OcjenaProvider() :super("Ocjena");

  @override
  Ocjena fromJson(data) {
    // TODO: implement fromJson
    return Ocjena.fromJson(data);
  }

  Future<double> getProsjecnaOcjena(int predstavaId) async {

    var url = "${BaseProvider.baseUrl}Ocjena/Prosjek?predstavaId=${predstavaId}";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    try {
      final response = await http.get(uri, headers: headers);
      if (isValidResponse(response)) {
        final obj = jsonDecode(response.body);
        return (obj as num).toDouble();
      } else {
        throw Exception("Server error");
      }
    } catch (e) {
      throw Exception("Greška prilikom dohvatanja prosječne ocjene: $e");
    }
  }
 }