// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vijest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vijest _$VijestFromJson(Map<String, dynamic> json) => Vijest(
      (json['vijestId'] as num?)?.toInt(),
      json['naziv'] as String?,
    )
      ..sadrzaj = json['sadrzaj'] as String?
      ..datum =
          json['datum'] == null ? null : DateTime.parse(json['datum'] as String)
      ..korisnikId = (json['korisnikId'] as num?)?.toInt();

Map<String, dynamic> _$VijestToJson(Vijest instance) => <String, dynamic>{
      'vijestId': instance.vijestId,
      'naziv': instance.naziv,
      'sadrzaj': instance.sadrzaj,
      'datum': instance.datum?.toIso8601String(),
      'korisnikId': instance.korisnikId,
    };
