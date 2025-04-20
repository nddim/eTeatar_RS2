// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repertoar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repertoar _$RepertoarFromJson(Map<String, dynamic> json) => Repertoar(
      (json['repertoarId'] as num?)?.toInt(),
      json['naziv'] as String?,
    )
      ..opis = json['opis'] as String?
      ..datumPocetka = json['datumPocetka'] == null
          ? null
          : DateTime.parse(json['datumPocetka'] as String)
      ..datumKraja = json['datumKraja'] == null
          ? null
          : DateTime.parse(json['datumKraja'] as String);

Map<String, dynamic> _$RepertoarToJson(Repertoar instance) => <String, dynamic>{
      'repertoarId': instance.repertoarId,
      'naziv': instance.naziv,
      'opis': instance.opis,
      'datumPocetka': instance.datumPocetka?.toIso8601String(),
      'datumKraja': instance.datumKraja?.toIso8601String(),
    };
