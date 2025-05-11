import 'package:eteatar_mobile/models/termin.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rezervacija.g.dart';

@JsonSerializable()
class Rezervacija {
  int? rezervacijaId;
  int? terminId;
  int? korisnikId;
  String? stateMachine;
  Termin? termin;

  Rezervacija(
    this.rezervacijaId,
    this.stateMachine,
  );

  factory Rezervacija.fromJson(Map<String, dynamic> json) => _$RezervacijaFromJson(json);

  /// Connect the generated [_$GlumacToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RezervacijaToJson(this);
}