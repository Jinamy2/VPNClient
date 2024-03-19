import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/getit_globals.dart';
import 'package:vpnclient/common/widgets/button_widget.dart';
import 'package:vpnclient/features/authorization/controllers/auth.provider.dart';
import 'package:vpnclient/features/authorization/widgets/text_auth_widget.dart';
import 'package:vpnclient/features/authorization/widgets/text_field_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColor.mainPurple,
        body: Consumer<AuthProvider>(
          builder: (context, _, __) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 6,
                ),
                const TextAuth(
                  text: 'Вход в приложение',
                ),
                const Spacer(),
                TextFieldWidget(
                  padding: const EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                  ),
                  keyboardType: TextInputType.text,
                  errorText: auth.loginValidation ? null : '*Логин не найден',
                  hintText: 'Введите логин',
                  onChange: (value) => auth.checkLoginChange(),
                  controller: auth.loginTextFieldController,
                ),
                TextFieldWidget(
                  padding: EdgeInsets.only(
                    bottom: auth.loading ? 20 : 100,
                  ),
                  keyboardType: TextInputType.text,
                  errorText:
                      auth.passwordValidation ? null : '*Неверный пароль',
                  hintText: 'Введите пароль',
                  onChange: (value) => auth.checkPasswordChange(),
                  controller: auth.passwordCheckTextFieldController,
                ),
                if (auth.loading)
                  const Flexible(child: CircularProgressIndicator()),
                Padding(
                  padding: EdgeInsets.only(top: auth.loading ? 20 : 0),
                  child: Button(
                    title: 'Войти',
                    colorButton: AppColor.activeButtonColor,
                    colorFont: AppColor.whiteColor,
                    onTap: auth.onEnterTab,
                    enable: auth.enableButton && !auth.loading,
                  ),
                ),
                const Spacer(
                  flex: 6,
                ),
              ],
            ),
          ),
        ),
      );
}
