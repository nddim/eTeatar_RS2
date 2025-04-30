import 'package:json_annotation/json_annotation.dart';

part 'dvorana.g.dart';

@JsonSerializable()
class Dvorana {
  int? dvoranaId;
  String? naziv;
  int? kapacitet;
  Dvorana(
    this.dvoranaId,
    this.naziv,
    this.kapacitet
  );

  factory Dvorana.fromJson(Map<String, dynamic> json) => _$DvoranaFromJson(json);

  /// Connect the generated [_$DvoranaToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DvoranaToJson(this);
}