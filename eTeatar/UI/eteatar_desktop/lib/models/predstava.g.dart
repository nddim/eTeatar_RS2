// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'predstava.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Predstava _$PredstavaFromJson(Map<String, dynamic> json) => Predstava(
      (json['predstavaId'] as num?)?.toInt(),
      json['naziv'] as String?,
    )
      ..cijena = (json['cijena'] as num?)?.toDouble()
      ..slika = json['slika'] as String?;

Map<String, dynamic> _$PredstavaToJson(Predstava instance) => <String, dynamic>{
      'predstavaId': instance.predstavaId,
      'naziv': instance.naziv,
      'cijena': instance.cijena,
      'slika': instance.slika,
    };
