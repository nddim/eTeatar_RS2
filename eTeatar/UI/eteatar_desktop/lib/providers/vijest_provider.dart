import 'package:eteatar_desktop/models/vijest.dart';
import 'package:eteatar_desktop/providers/base_provider.dart';

class VijestProvider extends BaseProvider<Vijest> {
  VijestProvider() :super("Vijest");

  @override
  Vijest fromJson(data) {
    // TODO: implement fromJson
    return Vijest.fromJson(data);
  }
 }