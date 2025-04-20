// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocjena.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ocjena _$OcjenaFromJson(Map<String, dynamic> json) => Ocjena(
      (json['ocjenaId'] as num?)?.toInt(),
      (json['vrijednost'] as num?)?.toInt(),
      json['komentar'] as String?,
    )
      ..predstavaId = (json['predstavaId'] as num?)?.toInt()
      ..korisnikId = (json['korisnikId'] as num?)?.toInt();

Map<String, dynamic> _$OcjenaToJson(Ocjena instance) => <String, dynamic>{
      'ocjenaId': instance.ocjenaId,
      'vrijednost': instance.vrijednost,
      'komentar': instance.komentar,
      'predstavaId': instance.predstavaId,
      'korisnikId': instance.korisnikId,
    };
