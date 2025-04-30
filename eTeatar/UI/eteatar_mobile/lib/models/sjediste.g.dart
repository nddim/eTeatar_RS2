// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sjediste.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sjediste _$SjedisteFromJson(Map<String, dynamic> json) => Sjediste(
      (json['sjedisteId'] as num?)?.toInt(),
      json['red'] as String?,
      json['kolona'] as String?,
    )
      ..status = json['status'] as String?
      ..dvoranaId = (json['dvoranaId'] as num?)?.toInt();

Map<String, dynamic> _$SjedisteToJson(Sjediste instance) => <String, dynamic>{
      'sjedisteId': instance.sjedisteId,
      'red': instance.red,
      'kolona': instance.kolona,
      'status': instance.status,
      'dvoranaId': instance.dvoranaId,
    };
