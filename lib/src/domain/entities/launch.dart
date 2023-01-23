import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Launch {
  final String id;
  final String name;
  final DatePrecision datePrecision;
  final int launchTimeUnix;

  const Launch({
    required this.id,
    required this.name,
    required this.datePrecision,
    required this.launchTimeUnix,
  });

  DateTime get launchDateTime =>
      DateTime.fromMillisecondsSinceEpoch(launchTimeUnix * 1000);

  String get launchDateString => DateFormat(
        datePrecision.resolve(day: 'dd/MM/yy', month: 'MM/yy', year: 'yy'),
      ).format(launchDateTime);
}

enum DatePrecision {
  year,
  month,
  day;

  T resolve<T>({required T year, required T month, required T day}) {
    switch (this) {
      case DatePrecision.year:
        return year;
      case DatePrecision.month:
        return month;
      case DatePrecision.day:
        return day;
    }
  }
}
