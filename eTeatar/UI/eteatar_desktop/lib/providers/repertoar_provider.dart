import 'package:eteatar_desktop/models/repertoar.dart';
import 'package:eteatar_desktop/providers/base_provider.dart';

class RepertoarProvider extends BaseProvider<Repertoar> {
  RepertoarProvider() :super("Glumac");

  @override
  Repertoar fromJson(data) {
    // TODO: implement fromJson
    return Repertoar.fromJson(data);
  }
 }