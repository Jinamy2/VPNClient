import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toastification/toastification.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';
import 'package:vpnclient/features/websites/widgets/button_long_widget.dart';

Future<void> _pickDirectory() async {
  final Directory? downloadDir = await getDownloadsDirectory();
  debugPrint('download dir ${downloadDir!.path}');
  final certif = await rootBundle.loadString('assets/files/ca-cert.pem');
  final File cert = await File('${downloadDir.path}/ca-cert.pem').create();
  debugPrint(cert.path);
  await cert.writeAsString(certif).then((value) async {
    toastification.show(
      alignment: Alignment.bottomCenter,
      primaryColor: AppColor.mainPurple,
      style: ToastificationStyle.fillColored,
      title: const Text('Файл сохранен в загрузках!'),
      showProgressBar: false,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }).catchError(
    (Object error) {
      toastification.show(
        type: ToastificationType.error,
        alignment: Alignment.bottomCenter,
        primaryColor: AppColor.mainPurple,
        style: ToastificationStyle.fillColored,
        title: const Text('Ошибка сохранения файла'),
        showProgressBar: false,
        autoCloseDuration: const Duration(seconds: 3),
      );
      return null;
    },
  );
}

Future<void> copyCommand() async {
  try {
    await Clipboard.setData(
      const ClipboardData(
        text:
            'Import-Certificate -CertStoreLocation cert:\\LocalMachine\\Root\\ -FilePath ~\\Documents\\ca-cert.pem',
      ),
    );
    toastification.show(
      alignment: Alignment.bottomCenter,
      primaryColor: AppColor.mainPurple,
      style: ToastificationStyle.fillColored,
      title: const Text('Скопировано!'),
      showProgressBar: false,
      autoCloseDuration: const Duration(seconds: 3),
    );
  } catch (e) {
    toastification.show(
      type: ToastificationType.error,
      alignment: Alignment.bottomCenter,
      primaryColor: AppColor.mainPurple,
      style: ToastificationStyle.fillColored,
      title: const Text('Ошибка копирования'),
      showProgressBar: false,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }
}

class WindowsCert extends StatelessWidget {
  const WindowsCert({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                '1. Установите файл "ca-cert.pem", содержащий корневой сертификат. Файл установится в загрузки',
                style: context.textTheme.headlineSmall!
                    .copyWith(color: AppColor.mainPurple),
                textAlign: TextAlign.left,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: ButtonLong(
                title: 'Установить',
                onTap: _pickDirectory,
                enable: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '2. Откройте командную строку PowerShell с правами администратора',
                style: context.textTheme.headlineSmall!
                    .copyWith(color: AppColor.mainPurple),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                '3. Введите следующую команду:\n Import-Certificate -CertStoreLocation cert:\\LocalMachine\\Root\\ -FilePath ~\\Downloads\\ca-cert.pem',
                style: context.textTheme.headlineSmall!
                    .copyWith(color: AppColor.mainPurple),
                textAlign: TextAlign.left,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: ButtonLong(
                title: 'Скопировать',
                onTap: copyCommand,
                enable: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                '4. Сертификат установлен!',
                style: context.textTheme.headlineSmall!
                    .copyWith(color: AppColor.mainPurple),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      );
}
