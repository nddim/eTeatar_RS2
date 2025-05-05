// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'karta_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KartaDTO _$KartaDTOFromJson(Map<String, dynamic> json) => KartaDTO(
      (json['kartaId'] as num).toInt(),
      (json['cijena'] as num).toDouble(),
      (json['sjedisteId'] as num).toInt(),
      json['red'] as String,
      json['kolona'] as String,
      (json['terminId'] as num).toInt(),
      DateTime.parse(json['datumVrijeme'] as String),
      json['nazivPredstave'] as String,
    );

Map<String, dynamic> _$KartaDTOToJson(KartaDTO instance) => <String, dynamic>{
      'kartaId': instance.kartaId,
      'cijena': instance.cijena,
      'sjedisteId': instance.sjedisteId,
      'red': instance.red,
      'kolona': instance.kolona,
      'terminId': instance.terminId,
      'datumVrijeme': instance.datumVrijeme.toIso8601String(),
      'nazivPredstave': instance.nazivPredstave,
    };
