import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';
import 'package:vpnclient/features/websites/widgets/button_long_widget.dart';

Future<void> _pickDirectory() async {
  final status = await Permission.manageExternalStorage.status;
  debugPrint('storage permission $status');
  if (status.isDenied) {
    await Permission.manageExternalStorage.request();
  }
  final certif = await rootBundle.loadString('assets/files/ca-cert.pem');
  await FilePicker.platform
      .getDirectoryPath(
    dialogTitle: 'Выберете, куда сохранить файл',
    lockParentWindow: true,
  )
      .then((value) async {
    debugPrint(
      'directory path - $value, ${await Permission.manageExternalStorage.status}',
    );
    if (!Platform.isIOS) {
      await File('$value/ca-cert.pem')
          .writeAsString(certif)
          .then(
            (value) => Fluttertoast.showToast(
              msg: 'Файл сохранен!',
            ),
          )
          .catchError(
        (Object error) {
          debugPrint(error.toString());
        },
      );
    }

    final path = value;
    debugPrint(path);
  }).catchError((Object error) {
    debugPrint(error.toString());
  });
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
                '2. Перейдите в «Настройки» и выберите пункт "Безопасность" ("Безопасность и конфиденциальность")',
                style: context.textTheme.headlineSmall!
                    .copyWith(color: AppColor.mainPurple),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                '3. Перейдите в «Дополнительные настройки» и выберите "Шифрование и учетные данные")',
                style: context.textTheme.headlineSmall!
                    .copyWith(color: AppColor.mainPurple),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                '4. В окне «Установка профиля» нажмите «Установить». Установите сертификаты сразу после загрузки, иначе они удалятся автоматически',
                style: context.textTheme.headlineSmall!
                    .copyWith(color: AppColor.mainPurple),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                '5. Вернитесь к основным настройкам (пункт 2) и перейдите в "Об этом устройстве"',
                style: context.textTheme.headlineSmall!
                    .copyWith(color: AppColor.mainPurple),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                '6. Выберите, пролистав вниз, пунт "Доверие сертификатам"',
                style: context.textTheme.headlineSmall!
                    .copyWith(color: AppColor.mainPurple),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                '6. В открывшемся окне выберете активным доверие к скаченному сертификату (VPN root CA)',
                style: context.textTheme.headlineSmall!
                    .copyWith(color: AppColor.mainPurple),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      );
}
