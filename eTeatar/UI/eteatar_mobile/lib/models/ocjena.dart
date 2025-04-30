import 'package:json_annotation/json_annotation.dart';

part 'ocjena.g.dart';

@JsonSerializable()
class Ocjena {
  int? ocjenaId;
  int? vrijednost;
  String? komentar;
  int? predstavaId;
  int? korisnikId;
  Ocjena(
    this.ocjenaId,
    this.vrijednost,
    this.komentar
  );

  factory Ocjena.fromJson(Map<String, dynamic> json) => _$OcjenaFromJson(json);

  /// Connect the generated [_$GlumacToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OcjenaToJson(this);
}