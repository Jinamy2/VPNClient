import 'package:flutter/material.dart';
import 'package:vpnclient/common/app_constants/app_routes.dart';
import 'package:vpnclient/common/app_constants/theme.dart';
import 'package:vpnclient/common/utils/navigator_key.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Vpn Core App',
        theme: appTheme,
        routes: Routes.routes,
        initialRoute: Routes.main,
      );
}
