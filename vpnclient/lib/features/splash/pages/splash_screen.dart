import 'package:flutter/material.dart';
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