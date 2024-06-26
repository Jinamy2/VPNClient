import 'package:flutter/material.dart';
import 'package:vpnclient/features/authorization/pages/auth_screen.dart';
import 'package:vpnclient/features/load_cert/pages/load_cert_page.dart';
import 'package:vpnclient/features/settings/settings_page.dart';
import 'package:vpnclient/features/splash/pages/splash_screen.dart';
import 'package:vpnclient/features/toggle_vpn/pages/main_screen.dart';
import 'package:vpnclient/features/websites/pages/websites_screen.dart';

class Routes {
  //Paths
  static const String auth = '/auth';
  static const String websites = '/websites';
  static const String main = '/main';
  static const String cert = '/cert';
  static const String settings = '/settings';
  static const String init = '/init';

  static final routes = <String, WidgetBuilder>{
    main: (BuildContext context) => const MainScreen(),
    settings: (BuildContext context) => const SettingsScreen(),
    auth: (BuildContext context) => const AuthScreen(),
    websites: (BuildContext context) => const WebsitesScreen(),
    init: (BuildContext context) => const InitPage(),
    cert: (BuildContext context) => const LoadCertScreen(),
  };
}
