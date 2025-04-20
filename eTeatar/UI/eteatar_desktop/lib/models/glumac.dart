import 'package:json_annotation/json_annotation.dart';

part 'glumac.g.dart';

@JsonSerializable()
class Glumac {
  int? glumacId;
  String? ime;
  String? prezime;
  String? biografija;
  Glumac(
    this.glumacId,
    this.ime,
    this.prezime,
    this.biografija
  );

  factory Glumac.fromJson(Map<String, dynamic> json) => _$GlumacFromJson(json);

  /// Connect the generated [_$GlumacToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GlumacToJson(this);
}