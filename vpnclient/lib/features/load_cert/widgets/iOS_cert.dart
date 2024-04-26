import 'package:flutter/material.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';
import 'package:vpnclient/features/websites/widgets/button_long_widget.dart';

class iOSCert extends StatelessWidget {
  const iOSCert({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                '1. Установите конфигурационный файл, содержащий корневой сертификат',
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
                '2. Перейдите в «Настройки» и выберите «Основные»',
                style: context.textTheme.headlineSmall!
                    .copyWith(color: AppColor.mainPurple),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                '3. Перейдите в «VPN и управление устройствов» и выберите профиль конфигурации VPN (VPN root CA)',
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

Future<void> _pickDirectory() async {
  // final certif = await rootBundle.loadString('assets/files/ca-cert.pem');
  // final directory = await getDownloadsDirectory();
  // final userCertPem = File('${directory!.path}/ca-cert.pem');
  // userCertPem.writeAsString(certif);

  // final path = directory!.path;
  // debugPrint(path);
  // TODO(Polina): add load certificat

  // try {
  //   await certif('$path/${certif.path.split('/').last}');
  //   ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
  //     const SnackBar(
  //       content: Text('Файл успешно сохранен в памяти устройства (документы)'),
  //     ),
  //   );
  // } catch (e) {
  //   ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
  //     const SnackBar(
  //       content: Text('Ошибка сохранения файла'),
  //     ),
  //   );
  //   debugPrint('Error: $e');
  // }
}
