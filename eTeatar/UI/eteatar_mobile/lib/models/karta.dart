import 'package:json_annotation/json_annotation.dart';

part 'karta.g.dart';

@JsonSerializable()
class Karta {
  int? kartaId;
  double? cijena;
  int? sjedisteId;
  int? terminId;
  int? rezervacijaId;
  int? korisnikId;
  Karta(
    this.kartaId,
    this.cijena,
    this.sjedisteId,
    this.terminId,
    this.korisnikId
  );

  factory Karta.fromJson(Map<String, dynamic> json) => _$KartaFromJson(json);

  /// Connect the generated [_$GlumacToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$KartaToJson(this);
}