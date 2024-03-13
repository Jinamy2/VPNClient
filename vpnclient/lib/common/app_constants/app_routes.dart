import 'package:flutter/material.dart';
import 'package:vpnclient/features/toggle_vpn/pages/main_screen.dart';

//ignore: avoid_classes_with_only_static_members
class Routes {
  //Paths
  static const String auth = '/auth';
  static const String websites = '/codeEmail';
  static const String main = '/main';

  static final routes = <String, WidgetBuilder>{
    //auth: (BuildContext context) => const CheckInPage(),
    //websites: (BuildContext context) => const ConfirmEmailPage(),
    main: (BuildContext context) => const MainScreen(),
  };
}
