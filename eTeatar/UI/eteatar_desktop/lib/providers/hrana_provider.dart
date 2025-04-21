import 'package:eteatar_desktop/models/hrana.dart';
import 'package:eteatar_desktop/providers/base_provider.dart';

class HranaProvider extends BaseProvider<Hrana> {
  HranaProvider() :super("Glumac");

  @override
  Hrana fromJson(data) {
    // TODO: implement fromJson
    return Hrana.fromJson(data);
  }
 }