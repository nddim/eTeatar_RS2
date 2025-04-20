import 'package:json_annotation/json_annotation.dart';

part 'stavka_uplate.g.dart';

@JsonSerializable()
class StavkaUplate {
  int? stavkaUplateId;
  int? kolicina;
  double? cijena;
  int? hranaId;
  int? uplataId;

  StavkaUplate(
    this.stavkaUplateId,
    this.kolicina,
    this.cijena
  );

  factory StavkaUplate.fromJson(Map<String, dynamic> json) => _$StavkaUplateFromJson(json);

  /// Connect the generated [_$GlumacToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$StavkaUplateToJson(this);
}