import 'package:json_annotation/json_annotation.dart';

part 'repertoar.g.dart';

@JsonSerializable()
class Repertoar {
  int? repertoarId;
  String? naziv;
  String? opis;
  DateTime? datumPocetka;
  DateTime? datumKraja;
  
  Repertoar(
    this.repertoarId,
    this.naziv
  );

  factory Repertoar.fromJson(Map<String, dynamic> json) => _$RepertoarFromJson(json);

  /// Connect the generated [_$GlumacToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RepertoarToJson(this);
}