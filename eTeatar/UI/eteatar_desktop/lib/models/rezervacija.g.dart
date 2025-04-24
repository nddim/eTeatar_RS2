// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezervacija _$RezervacijaFromJson(Map<String, dynamic> json) => Rezervacija(
      (json['rezervacijaId'] as num?)?.toInt(),
      json['status'] as String?,
    )
      ..terminId = (json['terminId'] as num?)?.toInt()
      ..korisnikId = (json['korisnikId'] as num?)?.toInt()
      ..stateMachine = json['stateMachine'] as String?;

Map<String, dynamic> _$RezervacijaToJson(Rezervacija instance) =>
    <String, dynamic>{
      'rezervacijaId': instance.rezervacijaId,
      'status': instance.status,
      'terminId': instance.terminId,
      'korisnikId': instance.korisnikId,
      'stateMachine': instance.stateMachine,
    };
