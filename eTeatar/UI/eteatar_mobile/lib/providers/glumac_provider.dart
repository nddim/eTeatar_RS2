import 'package:eteatar_mobile/models/glumac.dart';
import 'package:eteatar_mobile/providers/base_provider.dart';

class GlumacProvider extends BaseProvider<Glumac> {
  GlumacProvider() :super("Glumac");

  @override
  Glumac fromJson(data) {
    // TODO: implement fromJson
    return Glumac.fromJson(data);
  }
 }