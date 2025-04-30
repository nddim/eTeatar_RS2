import 'package:eteatar_mobile/models/hrana.dart';
import 'package:eteatar_mobile/providers/base_provider.dart';

class HranaProvider extends BaseProvider<Hrana> {
  HranaProvider() :super("Hrana");

  @override
  Hrana fromJson(data) {
    // TODO: implement fromJson
    return Hrana.fromJson(data);
  }
 }