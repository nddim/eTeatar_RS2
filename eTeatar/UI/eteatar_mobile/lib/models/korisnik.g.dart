// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Korisnik _$KorisnikFromJson(Map<String, dynamic> json) => Korisnik(
      (json['korisnikId'] as num?)?.toInt(),
      json['ime'] as String?,
      json['prezime'] as String?,
    )
      ..email = json['email'] as String?
      ..slika = json['slika'] as String?
      ..telefon = json['telefon'] as String?
      ..korisnickoIme = json['korisnickoIme'] as String?
      ..datumRodenja = json['datumRodenja'] == null
          ? null
          : DateTime.parse(json['datumRodenja'] as String)
      ..lozinka = json['lozinka'] as String?
      ..lozinkaPotvrda = json['lozinkaPotvrda'] as String?;

Map<String, dynamic> _$KorisnikToJson(Korisnik instance) => <String, dynamic>{
      'korisnikId': instance.korisnikId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'email': instance.email,
      'slika': instance.slika,
      'telefon': instance.telefon,
      'korisnickoIme': instance.korisnickoIme,
      'datumRodenja': instance.datumRodenja?.toIso8601String(),
      'lozinka': instance.lozinka,
      'lozinkaPotvrda': instance.lozinkaPotvrda,
    };
