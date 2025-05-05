import 'dart:convert';

import 'package:eteatar_mobile/models/karta_dto.dart';
import 'package:eteatar_mobile/providers/auth_provider.dart';
import 'package:eteatar_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class KartaDtoProvider extends BaseProvider<KartaDTO> {
  KartaDtoProvider() :super("Karta");

  @override
  KartaDTO fromJson(data) {
    // TODO: implement fromJson
    return KartaDTO.fromJson(data);
  }

  Future<List<KartaDTO>> getKarte() async {
    var url = "${BaseProvider.baseUrl}Karta/getKartasByKorisnik/${AuthProvider.korisnikId}";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    try {
      final response = await http.get(uri, headers: headers);

      if (isValidResponse(response)) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => KartaDTO.fromJson(e)).toList();
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Greška prilikom dohvatanja karata: $e");
    }
  }

 }