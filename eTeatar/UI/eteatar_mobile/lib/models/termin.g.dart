// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Termin _$TerminFromJson(Map<String, dynamic> json) => Termin(
      (json['terminId'] as num?)?.toInt(),
      json['datum'] == null ? null : DateTime.parse(json['datum'] as String),
    )
      ..status = json['status'] as String?
      ..predstavaId = (json['predstavaId'] as num?)?.toInt()
      ..dvoranaId = (json['dvoranaId'] as num?)?.toInt()
      ..predstava = json['predstava'] == null
          ? null
          : Predstava.fromJson(json['predstava'] as Map<String, dynamic>);

Map<String, dynamic> _$TerminToJson(Termin instance) => <String, dynamic>{
      'terminId': instance.terminId,
      'datum': instance.datum?.toIso8601String(),
      'status': instance.status,
      'predstavaId': instance.predstavaId,
      'dvoranaId': instance.dvoranaId,
      'predstava': instance.predstava,
    };
