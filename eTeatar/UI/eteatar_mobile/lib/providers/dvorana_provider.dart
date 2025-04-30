import 'package:eteatar_mobile/models/dvorana.dart';
import 'package:eteatar_mobile/providers/base_provider.dart';

class DvoranaProvider extends BaseProvider<Dvorana> {
  DvoranaProvider() :super("Dvorana");

  @override
  Dvorana fromJson(data) {
    // TODO: implement fromJson
    return Dvorana.fromJson(data);
  }
 }