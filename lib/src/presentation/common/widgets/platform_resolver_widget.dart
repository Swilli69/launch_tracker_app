import 'package:flutter/material.dart';
import 'dart:io';

class PlatformResolver extends StatelessWidget {
  const PlatformResolver({
    Key? key,
    required this.ios,
    required this.android,
  }) : super(key: key);

  final Widget ios;
  final Widget android;

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? android : ios;
  }
}
