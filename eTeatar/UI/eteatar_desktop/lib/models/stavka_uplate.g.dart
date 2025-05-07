// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stavka_uplate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StavkaUplate _$StavkaUplateFromJson(Map<String, dynamic> json) => StavkaUplate(
      (json['stavkaUplateId'] as num?)?.toInt(),
      (json['kolicina'] as num?)?.toInt(),
      (json['cijena'] as num?)?.toDouble(),
    )..uplataId = (json['uplataId'] as num?)?.toInt();

Map<String, dynamic> _$StavkaUplateToJson(StavkaUplate instance) =>
    <String, dynamic>{
      'stavkaUplateId': instance.stavkaUplateId,
      'kolicina': instance.kolicina,
      'cijena': instance.cijena,
      'uplataId': instance.uplataId,
    };
