// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uplata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Uplata _$UplataFromJson(Map<String, dynamic> json) => Uplata(
      (json['uplataId'] as num?)?.toInt(),
      (json['iznos'] as num?)?.toDouble(),
    )
      ..datum =
          json['datum'] == null ? null : DateTime.parse(json['datum'] as String)
      ..korisnikId = (json['korisnikId'] as num?)?.toInt()
      ..transakcijaId = json['transakcijaId'] as String?
      ..nacinPlacanja = json['nacinPlacanja'] as String?
      ..status = json['status'] as String?;

Map<String, dynamic> _$UplataToJson(Uplata instance) => <String, dynamic>{
      'uplataId': instance.uplataId,
      'iznos': instance.iznos,
      'datum': instance.datum?.toIso8601String(),
      'korisnikId': instance.korisnikId,
      'transakcijaId': instance.transakcijaId,
      'nacinPlacanja': instance.nacinPlacanja,
      'status': instance.status,
    };
