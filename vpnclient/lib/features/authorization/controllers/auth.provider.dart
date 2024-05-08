import 'package:flutter/material.dart';
import 'package:vpnclient/common/app_constants/app_routes.dart';
import 'package:vpnclient/common/utils/auth_data.dart';
import 'package:vpnclient/common/utils/navigator_key.dart';
import 'package:vpnclient/main.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider();
  bool loading = false;
  String login = '';
  String password = '';
  final loginTextFieldController = TextEditingController();
  final passwordCheckTextFieldController = TextEditingController();

  bool enableButton = false;

  bool loginValidation = true;
  bool passwordValidation = true;

  void sendToInitScreen() => Navigator.of(navigatorKey.currentContext!)
      .popUntil((route) => route.isFirst);

  void sendToMainScreen() => Navigator.of(navigatorKey.currentContext!)
      .pushNamedAndRemoveUntil(Routes.main, (route) => false);

  void setLoadingTo(bool value) {
    loading = value;
    notifyListeners();
  }

  Future<void> onEnterTab() async {
    loading = true;
    login = loginTextFieldController.text;
    password = passwordCheckTextFieldController.text;
    authData.containsKey(login)
        ? loginValidation = true
        : loginValidation = false;
    authData[login] == password
        ? passwordValidation = true
        : passwordValidation = false;
    await storage.write(key: 'login', value: login);
    await storage.write(key: 'password', value: password);
    notifyListeners();
    if (loginValidation && passwordValidation) {
      sendToMainScreen();
    }
    loading = false;
  }

  void checkLoginChange() {
    enableButton = loginTextFieldController.text.isNotEmpty &&
        passwordCheckTextFieldController.text.isNotEmpty;
    notifyListeners();
  }

  void checkPasswordChange() {
    enableButton = loginTextFieldController.text.isNotEmpty &&
        passwordCheckTextFieldController.text.isNotEmpty;
    notifyListeners();
  }
}
