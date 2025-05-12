// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'karta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Karta _$KartaFromJson(Map<String, dynamic> json) => Karta(
      (json['kartaId'] as num?)?.toInt(),
      (json['cijena'] as num?)?.toDouble(),
      (json['sjedisteId'] as num?)?.toInt(),
      (json['terminId'] as num?)?.toInt(),
      (json['korisnikId'] as num?)?.toInt(),
      json['ukljucenaHrana'] as bool?,
    )..rezervacijaId = (json['rezervacijaId'] as num?)?.toInt();

Map<String, dynamic> _$KartaToJson(Karta instance) => <String, dynamic>{
      'kartaId': instance.kartaId,
      'cijena': instance.cijena,
      'sjedisteId': instance.sjedisteId,
      'terminId': instance.terminId,
      'rezervacijaId': instance.rezervacijaId,
      'korisnikId': instance.korisnikId,
      'ukljucenaHrana': instance.ukljucenaHrana,
    };
