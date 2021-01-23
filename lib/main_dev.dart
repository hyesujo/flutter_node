import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_node/main.dart';
import 'package:flutter_node/provider/appConfig.dart';

void main() {
  const String kPort = '3002';
  final String baseUrl = Platform.isAndroid
      ? 'http://192.168.219.190:$kPort'
      : 'http://localhost:$kPort';
  final String dataUrl = '$baseUrl/dev';

  final appConfig =
      AppConfig(baseUrl: baseUrl, dataUrl: dataUrl, buildFlavor: 'dev');
  runApp(MyApp(appConfig));
}
