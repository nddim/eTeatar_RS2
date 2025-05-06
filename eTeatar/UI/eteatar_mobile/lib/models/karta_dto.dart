import 'package:json_annotation/json_annotation.dart';

part 'karta_dto.g.dart';

@JsonSerializable()
class KartaDTO {
  final int kartaId;
  final double cijena;
  final int sjedisteId;
  final String red;
  final String kolona;
  final int terminId;
  final DateTime datumVrijeme;
  final String nazivPredstave;
  final bool?  ukljucenaHrana;
  KartaDTO(
    this.kartaId,
    this.cijena,
    this.sjedisteId,
    this.red,
    this.kolona,
    this.terminId,
    this.datumVrijeme,
    this.nazivPredstave,
    this.ukljucenaHrana,
  );

  factory KartaDTO.fromJson(Map<String, dynamic> json) => _$KartaDTOFromJson(json);

  /// Connect the generated [_$GlumacToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$KartaDTOToJson(this);
}