// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dvorana.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dvorana _$DvoranaFromJson(Map<String, dynamic> json) => Dvorana(
      (json['dvoranaId'] as num?)?.toInt(),
      json['naziv'] as String?,
      (json['kapacitet'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DvoranaToJson(Dvorana instance) => <String, dynamic>{
      'dvoranaId': instance.dvoranaId,
      'naziv': instance.naziv,
      'kapacitet': instance.kapacitet,
    };
