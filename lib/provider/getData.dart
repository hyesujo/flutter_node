import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_node/provider/appConfig.dart';
import 'package:flutter_node/provider/auth.dart';
import 'package:http/http.dart' as http;

class GetDataProvider with ChangeNotifier {
  String _message;

  String get message => _message;

  AppConfig _appConFig;

  AppConfig get appConfig => _appConFig;

  set appConfig(AppConfig appConfigVal) {
    if (_appConFig != appConfigVal) {
      _appConFig = appConfigVal;
      notifyListeners();
    }
  }

  AuthProvider _auth;

  AuthProvider get auth => _auth;

  set auth(AuthProvider authVal) {
    if (_auth != authVal) {
      _auth = authVal;
      notifyListeners();
    }
  }

  Future<void> getData() async {
    try {
      final String url = '${appConfig.dataUrl}';

      final http.Response response = await http
          .get(url, headers: {'Authorization': 'Bearer ${auth.token}'});
      final resposeData = json.decode(response.body);

      if (response.statusCode != 200 || !resposeData['success']) {
        throw 'Fail to getData';
      }

      if (appConfig.buildFlavor == 'dev') {
        print(resposeData);
      }
      _message = resposeData['message'];
      notifyListeners();
    } catch (e) {
      if (appConfig.buildFlavor == 'dev') {
        print('error: $e');
      }
      throw e;
    }
  }
}
