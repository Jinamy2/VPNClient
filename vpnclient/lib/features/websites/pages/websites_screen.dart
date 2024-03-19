import 'package:flutter/material.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';
import 'package:vpnclient/common/utils/navigator_key.dart';
import 'package:vpnclient/common/widgets/app_bar/components/back_button.dart';
import 'package:vpnclient/features/websites/controllers/show_website_modal.dart';
import 'package:vpnclient/features/websites/widgets/button_with_icon.dart';
import 'package:vpnclient/features/websites/widgets/search_text_field_widget.dart';
import 'package:vpnclient/features/websites/widgets/websites_modal_content.dart';

class WebsitesScreen extends StatelessWidget {
  const WebsitesScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const BackButtonApp(),
          title: const Text('Сайты'),
          toolbarHeight:
              MediaQuery.of(navigatorKey.currentContext!).size.height * 0.13,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFieldSearch(
                hintText: 'Поиск по сайтам',
                onChange: (value) => {},
                controller: TextEditingController(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ButtonWithIcon(
                  title: 'Добавить сайт',
                  assetIcon: 'assets/plus.svg',
                  styleText: context.textTheme.headlineMedium!
                      .copyWith(color: AppColor.mainPurple),
                  onTap: () => showAddWebsiteModal(
                    context,
                    'Добавить сайт',
                    const ContentListWidgetWebsite(),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      );
}
