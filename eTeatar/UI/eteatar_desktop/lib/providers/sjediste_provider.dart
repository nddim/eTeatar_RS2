import 'package:eteatar_desktop/models/sjediste.dart';
import 'package:eteatar_desktop/providers/base_provider.dart';

class SjedisteProvider extends BaseProvider<Sjediste> {
  SjedisteProvider() :super("Sjediste");

  @override
  Sjediste fromJson(data) {
    // TODO: implement fromJson
    return Sjediste.fromJson(data);
  }
 }