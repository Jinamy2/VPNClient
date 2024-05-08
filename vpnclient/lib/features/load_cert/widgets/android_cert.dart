import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';
import 'package:vpnclient/features/websites/widgets/button_long_widget.dart';

Future<void> _pickDirectory() async {
  final status = await Permission.manageExternalStorage.status;
  final Directory generalDownloadDir =
      Directory('/storage/emulated/0/Download');
  debugPrint('storage permission $status');
  if (status.isDenied || status.isRestricted) {
    await Permission.manageExternalStorage.request();
    await Permission.storage.request();
  }
  if (status.isPermanentlyDenied) {
    await openAppSettings();
  }
  final bool cantLauchDownload = status.isDenied || status.isRestricted;
  final certif = await rootBundle.loadString('assets/files/ca-cert.pem');
  final directory =
      (await getExternalStorageDirectories(type: StorageDirectory.downloads))!
          .first;
  final File cert = cantLauchDownload
      ? await File('${directory.path}/ca-cert.pem').create()
      : await File('${generalDownloadDir.path}/ca-cert.pem').create();
  debugPrint(cert.path);
  await cert.writeAsString(certif).then((value) async {
    cantLauchDownload
        ? await Fluttertoast.showToast(
            msg: 'Файл сохранен по пути ${value.path}!',
          )
        : await Fluttertoast.showToast(
            msg: 'Файл сохранен в загрузки!',
          );
  }).catchError(
    (Object error) {
      Fluttertoast.showToast(
        msg: 'Ошибка сохранения файла.',
      );
      return null;
    },
  );
}

class AndroidCert extends StatelessWidget {
  const AndroidCert({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                '1. Установите файл "ca-cert.pem", содержащий корневой сертификат',
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
                '2. Перейдите в «Настройки» и перейдите в настройки безопасности',
                style: context.textTheme.headlineSmall!
                    .copyWith(color: AppColor.mainPurple),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                '3. Перейдите установку сертификатов и установите ЦС сертификат, скаченный по кнопке выше',
                style: context.textTheme.headlineSmall!
                    .copyWith(color: AppColor.mainPurple),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                '4. В параметрах безопасности убедитесь, что пользовательский сертификат установлен и устройство ему доверяет',
                style: context.textTheme.headlineSmall!
                    .copyWith(color: AppColor.mainPurple),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                '5. Шаги установки сертифката могут быть специфичны для разных моделей телефонов, в случае некорректной иструкции к вашему телефону обратитиесь в Интернет',
                style: context.textTheme.headlineSmall!
                    .copyWith(color: AppColor.mainPurple),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      );
}
