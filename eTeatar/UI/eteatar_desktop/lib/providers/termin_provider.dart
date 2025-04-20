import 'package:eteatar_desktop/models/termin.dart';
import 'package:eteatar_desktop/providers/base_provider.dart';

class TerminProvider extends BaseProvider<Termin> {
  TerminProvider() :super("Glumac");

  @override
  Termin fromJson(data) {
    // TODO: implement fromJson
    return Termin.fromJson(data);
  }
 }