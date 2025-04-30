import 'package:json_annotation/json_annotation.dart';

part 'zanr.g.dart';

@JsonSerializable()
class Zanr {
  int? zanrId;
  String? naziv;
  Zanr(
    this.zanrId,
    this.naziv
  );
  factory Zanr.fromJson(Map<String, dynamic> json) => _$ZanrFromJson(json);

  /// Connect the generated [_$PredstavaToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ZanrToJson(this);
}