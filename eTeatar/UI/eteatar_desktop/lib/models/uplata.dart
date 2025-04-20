import 'package:json_annotation/json_annotation.dart';

part 'uplata.g.dart';

@JsonSerializable()
class Uplata {
  int? uplataId;
  double? iznos;
  DateTime? datum;
  int? korisnikId;


  Uplata(
    this.uplataId,
    this.iznos
  );

  factory Uplata.fromJson(Map<String, dynamic> json) => _$UplataFromJson(json);

  /// Connect the generated [_$GlumacToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UplataToJson(this);
}