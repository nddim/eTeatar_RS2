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

  Korisnik(
    this.korisnikId,
    this.ime,
    this.prezime
  );

  factory Korisnik.fromJson(Map<String, dynamic> json) => _$KorisnikFromJson(json);

  /// Connect the generated [_$GlumacToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$KorisnikToJson(this);
}