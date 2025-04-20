import 'package:json_annotation/json_annotation.dart';

part 'sjediste.g.dart';

@JsonSerializable()
class Sjediste {
  int? sjedisteId;
  String? red;
  String? kolona;
  String? status;
  int? dvoranaId;

  Sjediste(
    this.sjedisteId,
    this.red,
    this.kolona
  );

  factory Sjediste.fromJson(Map<String, dynamic> json) => _$SjedisteFromJson(json);

  /// Connect the generated [_$GlumacToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SjedisteToJson(this);
}