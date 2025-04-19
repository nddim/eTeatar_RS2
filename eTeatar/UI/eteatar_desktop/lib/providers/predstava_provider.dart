import 'package:eteatar_desktop/models/predstava.dart';
import 'package:eteatar_desktop/providers/base_provider.dart';

class PredstavaProvider extends BaseProvider<Predstava> {
  PredstavaProvider() :super("Predstava");

  @override
  Predstava fromJson(data) {
    // TODO: implement fromJson
    return Predstava.fromJson(data);
  }
 }