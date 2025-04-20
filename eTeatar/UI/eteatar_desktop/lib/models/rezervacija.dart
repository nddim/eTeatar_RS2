import 'package:json_annotation/json_annotation.dart';

part 'rezervacija.g.dart';

@JsonSerializable()
class Rezervacija {
  int? rezervacijaId;
  String? status;
  int? terminId;
  int? korisnikId;

  Rezervacija(
    this.rezervacijaId,
    this.status,
  );

  factory Rezervacija.fromJson(Map<String, dynamic> json) => _$RezervacijaFromJson(json);

  /// Connect the generated [_$GlumacToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RezervacijaToJson(this);
}