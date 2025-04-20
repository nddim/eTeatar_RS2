import 'package:eteatar_desktop/models/ocjena.dart';
import 'package:eteatar_desktop/providers/base_provider.dart';

class OcjenaProvider extends BaseProvider<Ocjena> {
  OcjenaProvider() :super("Glumac");

  @override
  Ocjena fromJson(data) {
    // TODO: implement fromJson
    return Ocjena.fromJson(data);
  }
 }