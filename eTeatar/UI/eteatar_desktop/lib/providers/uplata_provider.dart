import 'package:eteatar_desktop/models/uplata.dart';
import 'package:eteatar_desktop/providers/base_provider.dart';

class UplataProvider extends BaseProvider<Uplata> {
  UplataProvider() :super("Glumac");

  @override
  Uplata fromJson(data) {
    // TODO: implement fromJson
    return Uplata.fromJson(data);
  }
 }