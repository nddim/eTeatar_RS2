import 'package:eteatar_desktop/models/zanr.dart';
import 'package:eteatar_desktop/providers/base_provider.dart';

class ZanrProvider extends BaseProvider<Zanr> {
  ZanrProvider() :super("Zanr");

  @override
  Zanr fromJson(data) {
    // TODO: implement fromJson
    return Zanr.fromJson(data);
  }
 }