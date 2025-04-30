import 'package:eteatar_mobile/models/uplata.dart';
import 'package:eteatar_mobile/providers/base_provider.dart';

class UplataProvider extends BaseProvider<Uplata> {
  UplataProvider() :super("Uplata");

  @override
  Uplata fromJson(data) {
    // TODO: implement fromJson
    return Uplata.fromJson(data);
  }
 }