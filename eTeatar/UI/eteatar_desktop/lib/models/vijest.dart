import 'package:json_annotation/json_annotation.dart';

part 'vijest.g.dart';

@JsonSerializable()
class Vijest {
  int? vijestId;
  String? naziv;
  String? sadrzaj;
  DateTime? datum;
  int? korisnikId;


  Vijest(
    this.vijestId,
    this.naziv
  );

  factory Vijest.fromJson(Map<String, dynamic> json) => _$VijestFromJson(json);

  /// Connect the generated [_$GlumacToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$VijestToJson(this);
}