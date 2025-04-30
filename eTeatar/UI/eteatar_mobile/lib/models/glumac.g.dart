// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glumac.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Glumac _$GlumacFromJson(Map<String, dynamic> json) => Glumac(
      (json['glumacId'] as num?)?.toInt(),
      json['ime'] as String?,
      json['prezime'] as String?,
      json['biografija'] as String?,
    );

Map<String, dynamic> _$GlumacToJson(Glumac instance) => <String, dynamic>{
      'glumacId': instance.glumacId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'biografija': instance.biografija,
    };
