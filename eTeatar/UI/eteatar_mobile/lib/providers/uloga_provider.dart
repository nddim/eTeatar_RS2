import 'package:eteatar_mobile/models/uloga.dart';
import 'package:eteatar_mobile/providers/base_provider.dart';

class UlogaProvider extends BaseProvider<Uloga> {
  UlogaProvider() :super("Uloga");

  @override
  Uloga fromJson(data) {
    // TODO: implement fromJson
    return Uloga.fromJson(data);
  }
 }