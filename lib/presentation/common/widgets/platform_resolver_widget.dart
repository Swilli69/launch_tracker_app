import 'dart:io';
import 'package:flutter/material.dart';

class PlatformResolver extends StatelessWidget {
  const PlatformResolver({
    super.key,
    required this.ios,
    required this.android,
  });

  final Widget ios;
  final Widget android;

  @override
  Widget build(BuildContext context) => Platform.isAndroid ? android : ios;
}
