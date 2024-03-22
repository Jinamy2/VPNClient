import 'package:flutter/material.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';
import 'package:vpnclient/common/widgets/button_widget.dart';
import 'package:vpnclient/features/websites/widgets/button_long_widget.dart';
import 'package:vpnclient/features/websites/widgets/search_text_field_widget.dart';

class ContentListWidgetWebsite extends StatefulWidget {
  const ContentListWidgetWebsite({
    super.key,
  });

  @override
  State<ContentListWidgetWebsite> createState() =>
      ContentListWidgetWebsiteState();
}

class ContentListWidgetWebsiteState extends State<ContentListWidgetWebsite> {
  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: TextFieldSearch(
                padding: EdgeInsets.zero,
                onChange: (_) => (),
                hintText: 'Введите доменное имя',
                controller: TextEditingController(),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                'Введите доменное имя формата: example.com',
                style: context.textTheme.bodyLarge!
                    .copyWith(color: AppColor.hintTextStyleColor, fontSize: 11),
              ),
            ),
            ButtonLong(
              title: 'Добавить',
              onTap: () => {},
              enable: false,
            ),
          ],
        ),
      );
}
