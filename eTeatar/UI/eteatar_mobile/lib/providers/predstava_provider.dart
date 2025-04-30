import 'package:eteatar_mobile/models/predstava.dart';
import 'package:eteatar_mobile/providers/base_provider.dart';

class PredstavaProvider extends BaseProvider<Predstava> {
  PredstavaProvider() :super("Predstava");

  @override
  Predstava fromJson(data) {
    // TODO: implement fromJson
    return Predstava.fromJson(data);
  }
 }