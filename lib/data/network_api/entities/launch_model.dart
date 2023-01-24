import 'package:json_annotation/json_annotation.dart';
import 'package:launch_tracker_app/domain/entities/launch.dart';

part 'launch_model.g.dart';

enum DatePrecisionModel {
  quarter,
  half,
  year,
  month,
  day,
  hour;

  DatePrecision get datePrecision {
    switch (this) {
      case DatePrecisionModel.quarter:
        return DatePrecision.year;
      case DatePrecisionModel.half:
        return DatePrecision.year;
      case DatePrecisionModel.year:
        return DatePrecision.year;
      case DatePrecisionModel.month:
        return DatePrecision.month;
      case DatePrecisionModel.day:
        return DatePrecision.day;
      case DatePrecisionModel.hour:
        return DatePrecision.day;
    }
  }
}

@JsonSerializable()
class LaunchModel {
  final String id;
  final String name;
  @JsonKey(name: 'date_precision')
  final DatePrecisionModel datePrecisionModel;
  @JsonKey(name: 'date_unix')
  final int launchTimeUnix;

  const LaunchModel(
    this.id,
    this.name,
    this.datePrecisionModel,
    this.launchTimeUnix,
  );

  factory LaunchModel.fromJson(Map<String, dynamic> json) =>
      _$LaunchModelFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchModelToJson(this);

  Launch get launch => Launch(
        id: id,
        name: name,
        datePrecision: datePrecisionModel.datePrecision,
        //We add 365 days (in seconds) because launches from API are outdated
        launchTimeUnix: launchTimeUnix + 365 * 24 * 60 * 60,
      );
}
