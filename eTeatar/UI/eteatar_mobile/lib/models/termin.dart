import 'package:eteatar_mobile/models/predstava.dart';
import 'package:json_annotation/json_annotation.dart';

part 'termin.g.dart';

@JsonSerializable()
class Termin {
  int? terminId;
  DateTime? datum;
  String? status;
  int? predstavaId;
  int? dvoranaId;
  Predstava? predstava;

  Termin(
    this.terminId,
    this.datum
  );

  factory Termin.fromJson(Map<String, dynamic> json) => _$TerminFromJson(json);

  /// Connect the generated [_$GlumacToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TerminToJson(this);
}