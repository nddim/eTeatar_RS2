import 'package:eteatar_desktop/models/stavka_uplate.dart';
import 'package:eteatar_desktop/providers/base_provider.dart';

class StavkaUplateProvider extends BaseProvider<StavkaUplate> {
  StavkaUplateProvider() :super("Glumac");

  @override
  StavkaUplate fromJson(data) {
    // TODO: implement fromJson
    return StavkaUplate.fromJson(data);
  }
 }