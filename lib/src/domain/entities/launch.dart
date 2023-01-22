import 'package:json_annotation/json_annotation.dart';

part 'launch.g.dart';

@JsonSerializable()
class Launch {
  final String id;
  final String name;
  @JsonKey(name: 'date_unix')
  final int launchTimeUnix;

  const Launch(
    this.name,
    this.id,
    this.launchTimeUnix,
  );

  DateTime get launchDateTime =>
      DateTime.fromMillisecondsSinceEpoch(launchTimeUnix * 1000);

  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchToJson(this);
}
