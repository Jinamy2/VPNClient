import 'package:flutter/material.dart';
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
              PushToPageButton(
                padding: const EdgeInsets.all(20),
                onTap: () {},
                title: 'Сайты',
                assetIcon: 'assets/website.svg',
              ),
              const Spacer(),
            ],
          ),
        ),
      );
}
