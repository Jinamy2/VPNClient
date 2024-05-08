import 'package:flutter/material.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';

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
                '1. Установите файл "ca-cert.pem", содержащий корневой сертификат. Файл можно найти в папке приложения через "Файлы". Скопируйте его в нужную папку внe приложения и нажмите для загрузки',
                style: context.textTheme.headlineSmall!
                    .copyWith(color: AppColor.mainPurple),
                textAlign: TextAlign.left,
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
