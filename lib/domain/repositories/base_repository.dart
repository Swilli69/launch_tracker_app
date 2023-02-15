import 'package:flutter/foundation.dart';

abstract class BaseRepository {
  const BaseRepository();

  @mustCallSuper
  void dispose() {}
}
