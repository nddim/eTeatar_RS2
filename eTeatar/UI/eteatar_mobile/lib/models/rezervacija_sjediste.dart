import 'package:json_annotation/json_annotation.dart';

part 'rezervacija_sjediste.g.dart';

@JsonSerializable()
class RezervacijaSjediste {
  int? rezervacijaSjedisteId;
  int? rezervacijaId;
  int? sjedisteId;

  RezervacijaSjediste(
    this.rezervacijaSjedisteId,
    this.rezervacijaId,
    this.sjedisteId,
  );

  factory RezervacijaSjediste.fromJson(Map<String, dynamic> json) => _$RezervacijaSjedisteFromJson(json);

  /// Connect the generated [_$RezervacijaSjedisteToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RezervacijaSjedisteToJson(this);
}