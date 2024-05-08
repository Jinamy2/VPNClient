import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';
import 'package:vpnclient/common/utils/navigator_key.dart';
import 'package:vpnclient/common/widgets/app_bar/components/back_button.dart';
import 'package:vpnclient/features/websites/controllers/website_provider.dart';
import 'package:vpnclient/features/websites/widgets/all_websites_widget.dart';
import 'package:vpnclient/features/websites/widgets/button_with_icon.dart';
import 'package:vpnclient/features/websites/widgets/search_text_field_widget.dart';
import 'package:vpnclient/features/websites/widgets/show_website_modal.dart';
import 'package:vpnclient/features/websites/widgets/websites_modal_content.dart';

class WebsitesScreen extends StatelessWidget {
  const WebsitesScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => RoutingSettingsProvider(),
        child: Consumer<RoutingSettingsProvider>(
          builder: (context, provider, _) => Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: const BackButtonApp(),
              title: const Text('Исключения'),
              toolbarHeight:
                  MediaQuery.of(navigatorKey.currentContext!).size.height *
                      0.13,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFieldSearch(
                    hintText: 'Поиск по исключениям',
                    onChange: (_) => provider.searchInUserWebsites(),
                    controller: provider.userWebsitesController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ButtonWithIcon(
                      title: 'Добавить исключение',
                      assetIcon: 'assets/plus.svg',
                      styleText: context.textTheme.headlineMedium!
                          .copyWith(color: AppColor.mainPurple),
                      onTap: () => showAddWebsiteModal(
                        context,
                        'Добавить исключение',
                        ContentListWidgetWebsite(provider: provider),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final e in provider.currentUserWebsitesList)
                              WebsitesListView(
                                title: e.domen ?? e.ip ?? 'Неизвестно',
                                ruleType: e.ruleType!,
                                onChange: (ruleType) =>
                                    provider.changeRoutingType(
                                  e.id,
                                  ruleType,
                                ),
                                onDelete: () => provider.delete(
                                  e.id,
                                  e.domen ?? e.ip!,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
