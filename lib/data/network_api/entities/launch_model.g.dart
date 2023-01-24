// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchModel _$LaunchModelFromJson(Map<String, dynamic> json) => LaunchModel(
      json['id'] as String,
      json['name'] as String,
      $enumDecode(_$DatePrecisionModelEnumMap, json['date_precision']),
      json['date_unix'] as int,
    );

Map<String, dynamic> _$LaunchModelToJson(LaunchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date_precision':
          _$DatePrecisionModelEnumMap[instance.datePrecisionModel]!,
      'date_unix': instance.launchTimeUnix,
    };

const _$DatePrecisionModelEnumMap = {
  DatePrecisionModel.quarter: 'quarter',
  DatePrecisionModel.half: 'half',
  DatePrecisionModel.year: 'year',
  DatePrecisionModel.month: 'month',
  DatePrecisionModel.day: 'day',
  DatePrecisionModel.hour: 'hour',
};
