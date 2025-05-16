// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik_uloga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisnikUloga _$KorisnikUlogaFromJson(Map<String, dynamic> json) =>
    KorisnikUloga(
      (json['korisnikUlogaId'] as num?)?.toInt(),
      (json['korisnikId'] as num?)?.toInt(),
      (json['ulogaId'] as num?)?.toInt(),
      json['uloga'] == null
          ? null
          : Uloga.fromJson(json['uloga'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KorisnikUlogaToJson(KorisnikUloga instance) =>
    <String, dynamic>{
      'korisnikUlogaId': instance.korisnikUlogaId,
      'korisnikId': instance.korisnikId,
      'ulogaId': instance.ulogaId,
      'uloga': instance.uloga,
    };
