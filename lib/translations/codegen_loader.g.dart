// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "common": {
    "loading_error": "Something went wrong",
    "try_again": "Try again"
  },
  "launches": {
    "upcoming_launches": "Upcoming Launches",
    "mission": "Mission",
    "date_utc": "Date (UTC)",
    "no_launches": "Oh no, we don't have launches anymore",
    "no_favorite_launches": "Seems like you don't like launches ;(",
    "all": "All",
    "favorite": "Favorite"
  },
  "countdown": {
    "days": "Days",
    "hours": "Hours",
    "minutes": "Minutes",
    "seconds": "Seconds"
  },
  "share": {
    "share_launch": "Hurry up, the {name} will be launched on {date}"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en};
}
