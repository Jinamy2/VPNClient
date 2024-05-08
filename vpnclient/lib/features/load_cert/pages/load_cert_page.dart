import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vpnclient/common/utils/navigator_key.dart';
import 'package:vpnclient/common/widgets/app_bar/components/back_button.dart';
import 'package:vpnclient/features/load_cert/widgets/android_cert.dart';
import 'package:vpnclient/features/load_cert/widgets/iOS_cert.dart';

class LoadCertScreen extends StatelessWidget {
  const LoadCertScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const BackButtonApp(),
          title: const Text(
            'Инструкция установки \nсертификата',
            textAlign: TextAlign.center,
          ),
          toolbarHeight:
              MediaQuery.of(navigatorKey.currentContext!).size.height * 0.13,
        ),
        body: Center(
          child: Platform.isIOS ? const iOSCert() : const AndroidCert(),
        ),
      );
}
