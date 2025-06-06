import 'package:json_annotation/json_annotation.dart';

part 'predstava.g.dart';

@JsonSerializable()
class Predstava {
  int? predstavaId;
  String? naziv;
  double? cijena;
  String? slika;
  String? opis;
  String? produkcija;
  String? koreografija;
  String? scenografija;
  List<int>? zanrovi; 
  List<int>? glumci; 
  int? trajanje;

  Predstava(
    this.predstavaId,
    this.naziv
  );
  factory Predstava.fromJson(Map<String, dynamic> json) => _$PredstavaFromJson(json);

  /// Connect the generated [_$PredstavaToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PredstavaToJson(this);
}