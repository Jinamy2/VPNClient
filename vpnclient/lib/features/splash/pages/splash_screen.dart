import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ikev2_dart/ikev2_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/app_constants/app_routes.dart';
import 'package:vpnclient/common/utils/getit_globals.dart';
import 'package:vpnclient/common/utils/navigator_key.dart';
import 'package:vpnclient/main.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  void sendToAuthScreen() => Navigator.of(navigatorKey.currentContext!)
      .pushNamedAndRemoveUntil(Routes.auth, (route) => false);

  @override
  void initState() {
    super.initState();
    checkSession();

    /// try and find userId in SecureStorage
    storage.read(key: 'login').then((login) {
      if (login != null) {
        auth.login = login;
        storage.read(key: 'password').then(
          (password) {
            if (password != null) auth.password = password;
          },
        ).then(
          (_) => auth.login.isEmpty || auth.password.isEmpty
              ? sendToAuthScreen()
              : auth.sendToMainScreen(),
        );
      } else {
        sendToAuthScreen();
      }
    });
  }

  Future<void> checkSession() async {
    final keysToEliminate = [
      'login',
      'password',
    ];

    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('first_run') ?? true) {
      await Future.wait(keysToEliminate.map((key) => storage.delete(key: key)));
      if (Platform.isIOS) {
        final certif = await rootBundle.loadString('assets/files/ca-cert.pem');
        await Ikev2Dart.saveFile('path', certif);
      }

      await prefs.setBool('first_run', false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        backgroundColor: AppColor.splashScreenColor,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
}
