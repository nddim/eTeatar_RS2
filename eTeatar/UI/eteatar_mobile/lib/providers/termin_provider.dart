import 'package:eteatar_mobile/models/termin.dart';
import 'package:eteatar_mobile/providers/base_provider.dart';

class TerminProvider extends BaseProvider<Termin> {
  TerminProvider() :super("Termin");

  @override
  Termin fromJson(data) {
    // TODO: implement fromJson
    return Termin.fromJson(data);
  }
 }