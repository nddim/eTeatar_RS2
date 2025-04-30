// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hrana.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hrana _$HranaFromJson(Map<String, dynamic> json) => Hrana(
      (json['hranaId'] as num?)?.toInt(),
      json['naziv'] as String?,
      (json['cijena'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HranaToJson(Hrana instance) => <String, dynamic>{
      'hranaId': instance.hranaId,
      'naziv': instance.naziv,
      'cijena': instance.cijena,
    };
