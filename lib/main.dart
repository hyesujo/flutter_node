import 'package:flutter/material.dart';
import 'package:flutter_node/provider/appConfig.dart';
import 'package:flutter_node/provider/auth.dart';
import 'package:flutter_node/provider/getData.dart';
import 'package:flutter_node/screen/dashboardScreen.dart';
import 'package:flutter_node/screen/loginScreen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final appConfiguration;

  MyApp(this.appConfiguration);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppConfig>.value(value: appConfiguration),
        ChangeNotifierProxyProvider<AppConfig, AuthProvider>(
          create: (_) => AuthProvider(),
          update: (_, appConfig, authNotifier) {
            authNotifier.appConfig = appConfig;
            return authNotifier;
          },
        ),
        ChangeNotifierProxyProvider2<AppConfig, AuthProvider, GetDataProvider>(
            create: (_) => GetDataProvider(),
            update: (_, appConfig, auth, getDataNotifier) {
              getDataNotifier.appConfig = appConfig;
              getDataNotifier.auth = auth;
              return getDataNotifier;
            })
      ],
      child: MaterialApp(
        title: 'Flutter Node',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          DashBoardScreen.routeName: (context) => DashBoardScreen(),
        },
      ),
    );
  }
}
