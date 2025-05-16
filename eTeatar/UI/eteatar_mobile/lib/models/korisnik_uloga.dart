
import 'package:eteatar_mobile/models/uloga.dart';
import 'package:json_annotation/json_annotation.dart';

part 'korisnik_uloga.g.dart';

@JsonSerializable()
class KorisnikUloga {
  int? korisnikUlogaId;
  int? korisnikId;
  int? ulogaId;
  Uloga? uloga;
  KorisnikUloga(
    this.korisnikUlogaId,
    this.korisnikId,
    this.ulogaId,
    this.uloga,
  );

  factory KorisnikUloga.fromJson(Map<String, dynamic> json) => _$KorisnikUlogaFromJson(json);

  /// Connect the generated [_$GlumacToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$KorisnikUlogaToJson(this);
}