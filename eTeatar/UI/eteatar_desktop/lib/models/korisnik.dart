import 'package:eteatar_desktop/models/korisnik_uloga.dart';
import 'package:json_annotation/json_annotation.dart';

part 'korisnik.g.dart';

@JsonSerializable()
class Korisnik {
  int? korisnikId;
  String? ime;
  String? prezime;
  String? email;
  String? slika;
  String? telefon;
  String? korisnickoIme;
  DateTime? datumRodenja;
  String? lozinka;
  String? lozinkaPotvrda;
  List<KorisnikUloga> korisnikUlogas;

  Korisnik({
  this.korisnikId,
  this.ime,
  this.prezime,
  this.email,
  this.slika,
  this.telefon,
  this.korisnickoIme,
  this.datumRodenja,
  this.lozinka,
  this.lozinkaPotvrda,
  this.korisnikUlogas = const [],
});

  factory Korisnik.fromJson(Map<String, dynamic> json) => _$KorisnikFromJson(json);

  /// Connect the generated [_$GlumacToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$KorisnikToJson(this);
}