import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_node/provider/appConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String _token;

  String get token {
    return _token != null ? _token : null;
  }

  bool get isAuth => token != null;

  AppConfig _appConFig;
  AppConfig get appConfig => _appConFig;

  set appConfig(AppConfig appConfigVal) {
    if (_appConFig != appConfigVal) {
      _appConFig = appConfigVal;
      notifyListeners();
    }
  }

  Future<void> login() async {
    try {
      final String url = '${appConfig.baseUrl}/login';

      await Future.delayed(Duration(seconds: 2));
      final http.Response response = await http.get(url);
      final resposeData = json.decode(response.body);

      if (response.statusCode != 200 || !resposeData['success']) {
        throw 'Fail to login';
      }
      _token = resposeData['token'];
      if (appConfig.buildFlavor == 'dev') {
        print('token : $token');
      }
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      await preferences.setString('jwtToken', _token);

      notifyListeners();
    } catch (e) {
      if (appConfig.buildFlavor == 'dev') {
        print('error: $e');
      }
      throw e;
    }
  }

  Future<bool> tryAutoLogin() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      if (!preferences.containsKey('jwtToken')) {
        return false;
      }
      _token = preferences.getString('jwtToken');
      notifyListeners();

      return true;
    } catch (e) {
      throw '로그인 여부 체크 실패';
    }
  }

  Future<void> logout() async {
    _token = null;
    notifyListeners();
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('jwtToken');
  }
}
