import 'package:flutter/material.dart';
import 'package:vpnclient/common/app_constants/app_routes.dart';
import 'package:vpnclient/common/utils/auth_data.dart';
import 'package:vpnclient/common/utils/navigator_key.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider();
  bool loading = false;
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

  void onEnterTab() {
    loading = true;
    authData.containsKey(loginTextFieldController.text)
        ? loginValidation = true
        : loginValidation = false;
    authData[loginTextFieldController.text] ==
            passwordCheckTextFieldController.text
        ? passwordValidation = true
        : passwordValidation = false;
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
