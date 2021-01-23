import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_node/main.dart';
import 'package:flutter_node/provider/appConfig.dart';

void main() {
  const String kPort = '3002';
  final String baseUrl = Platform.isAndroid
      ? 'http://localhost:$kPort'
      : 'http://192.168.219.190:$kPort';
  final String dataUrl = '$baseUrl/prod';

  final appConfig =
      AppConfig(baseUrl: baseUrl, dataUrl: dataUrl, buildFlavor: 'prod');
  runApp(MyApp(appConfig));
}
