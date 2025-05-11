// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezervacija _$RezervacijaFromJson(Map<String, dynamic> json) => Rezervacija(
      (json['rezervacijaId'] as num?)?.toInt(),
      json['stateMachine'] as String?,
    )
      ..terminId = (json['terminId'] as num?)?.toInt()
      ..korisnikId = (json['korisnikId'] as num?)?.toInt()
      ..termin = json['termin'] == null
          ? null
          : Termin.fromJson(json['termin'] as Map<String, dynamic>);

Map<String, dynamic> _$RezervacijaToJson(Rezervacija instance) =>
    <String, dynamic>{
      'rezervacijaId': instance.rezervacijaId,
      'terminId': instance.terminId,
      'korisnikId': instance.korisnikId,
      'stateMachine': instance.stateMachine,
      'termin': instance.termin,
    };
