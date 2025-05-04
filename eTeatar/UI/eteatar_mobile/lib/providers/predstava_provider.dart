import 'dart:convert';

import 'package:eteatar_mobile/models/predstava.dart';
import 'package:eteatar_mobile/providers/auth_provider.dart';
import 'package:eteatar_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class PredstavaProvider extends BaseProvider<Predstava> {
  PredstavaProvider() :super("Predstava");

  @override
  Predstava fromJson(data) {
    // TODO: implement fromJson
    return Predstava.fromJson(data);
  }

  Future<List<Predstava>> getProslePredstave() async{
    var url = "${BaseProvider.baseUrl}Predstava/arhivaPredstava?korisnikId=${AuthProvider.korisnikId}";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response;
    try {
      response = await http.get(uri, headers: headers);
    } on Exception catch (e) {
      throw Exception("Greška prilikom dohvatanja arhive predstave : $e");
    }
    if (isValidResponse(response)) {
      var obj = jsonDecode(response.body);

      if (obj is List) {
        List<Predstava> lista = obj.map((item) => Predstava.fromJson(item)).toList();
        return lista; 
      } else {
        throw Exception("Očekivana lista iz JSON odgovora.");
      }
    }
    throw Exception("Greška");
  }
 }