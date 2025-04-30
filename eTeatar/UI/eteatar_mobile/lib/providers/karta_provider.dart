import 'package:eteatar_mobile/models/karta.dart';
import 'package:eteatar_mobile/providers/base_provider.dart';

class KartaProvider extends BaseProvider<Karta> {
  KartaProvider() :super("Karta");

  @override
  Karta fromJson(data) {
    // TODO: implement fromJson
    return Karta.fromJson(data);
  }
 }