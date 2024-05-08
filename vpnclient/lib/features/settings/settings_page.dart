import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vpnclient/common/app_constants/app_routes.dart';
import 'package:vpnclient/common/utils/navigator_key.dart';
import 'package:vpnclient/common/widgets/app_bar/components/back_button.dart';
import 'package:vpnclient/common/widgets/push_to_page_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const BackButtonApp(),
          title: const Text('Настройки VPN'),
          toolbarHeight:
              MediaQuery.of(navigatorKey.currentContext!).size.height * 0.13,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!Platform.isIOS)
                PushToPageButton(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  onTap: () => Navigator.of(context).pushNamed(Routes.websites),
                  title: 'Исключения',
                  assetIcon: 'assets/website.svg',
                ),
              PushToPageButton(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                  top: 20,
                ),
                onTap: () => Navigator.of(context).pushNamed(Routes.cert),
                title: 'Инструкция установки сертификата',
                assetIcon: 'assets/files.svg',
              ),
              const Spacer(),
            ],
          ),
        ),
      );
}
