import 'package:eteatar_mobile/models/korisnik.dart';
import 'package:eteatar_mobile/providers/base_provider.dart';

class KorisnikProvider extends BaseProvider<Korisnik> {
  KorisnikProvider() :super("Korisnik");

  @override
  Korisnik fromJson(data) {
    // TODO: implement fromJson
    return Korisnik.fromJson(data);
  }
 }