// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija_sjediste.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijaSjediste _$RezervacijaSjedisteFromJson(Map<String, dynamic> json) =>
    RezervacijaSjediste(
      (json['rezervacijaSjedisteId'] as num?)?.toInt(),
      (json['rezervacijaId'] as num?)?.toInt(),
      (json['sjedisteId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RezervacijaSjedisteToJson(
        RezervacijaSjediste instance) =>
    <String, dynamic>{
      'rezervacijaSjedisteId': instance.rezervacijaSjedisteId,
      'rezervacijaId': instance.rezervacijaId,
      'sjedisteId': instance.sjedisteId,
    };
