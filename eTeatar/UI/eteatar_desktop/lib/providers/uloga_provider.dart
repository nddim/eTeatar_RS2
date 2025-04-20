import 'package:eteatar_desktop/models/uloga.dart';
import 'package:eteatar_desktop/providers/base_provider.dart';

class UlogaProvider extends BaseProvider<Uloga> {
  UlogaProvider() :super("Glumac");

  @override
  Uloga fromJson(data) {
    // TODO: implement fromJson
    return Uloga.fromJson(data);
  }
 }