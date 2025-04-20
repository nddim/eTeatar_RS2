import 'package:json_annotation/json_annotation.dart';

part 'hrana.g.dart';

@JsonSerializable()
class Hrana {
  int? hranaId;
  String? naziv;
  double? cijena;
  Hrana(
    this.hranaId,
    this.naziv,
    this.cijena
  );

  factory Hrana.fromJson(Map<String, dynamic> json) => _$HranaFromJson(json);

  /// Connect the generated [_$GHranaToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$HranaToJson(this);
}