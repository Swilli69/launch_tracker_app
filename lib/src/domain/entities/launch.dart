import 'package:flutter/foundation.dart';

@immutable
class Launch {
  final String id;
  final String name;
  final int launchTime;

  const Launch(
    this.name,
    this.id,
    this.launchTime,
  );

  Launch.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        launchTime = json['date_unix'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date_unix': launchTime,
      };
}
