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
      ..slika = json['slika'] as String?
      ..opis = json['opis'] as String?
      ..produkcija = json['produkcija'] as String?
      ..koreografija = json['koreografija'] as String?
      ..scenografija = json['scenografija'] as String?
      ..trajanjePocetak = json['trajanjePocetak'] == null
          ? null
          : DateTime.parse(json['trajanjePocetak'] as String)
      ..trajanjeKraj = json['trajanjeKraj'] == null
          ? null
          : DateTime.parse(json['trajanjeKraj'] as String);

Map<String, dynamic> _$PredstavaToJson(Predstava instance) => <String, dynamic>{
      'predstavaId': instance.predstavaId,
      'naziv': instance.naziv,
      'cijena': instance.cijena,
      'slika': instance.slika,
      'opis': instance.opis,
      'produkcija': instance.produkcija,
      'koreografija': instance.koreografija,
      'scenografija': instance.scenografija,
      'trajanjePocetak': instance.trajanjePocetak?.toIso8601String(),
      'trajanjeKraj': instance.trajanjeKraj?.toIso8601String(),
    };
