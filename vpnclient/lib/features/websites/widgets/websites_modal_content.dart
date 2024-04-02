import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';
import 'package:vpnclient/features/websites/controllers/website_provider.dart';
import 'package:vpnclient/features/websites/widgets/button_long_widget.dart';
import 'package:vpnclient/features/websites/widgets/search_text_field_widget.dart';

class ContentListWidgetWebsite extends StatefulWidget {
  const ContentListWidgetWebsite({
    required this.provider,
    super.key,
  });

  final RoutingSettingsProvider provider;

  @override
  State<ContentListWidgetWebsite> createState() =>
      ContentListWidgetWebsiteState();
}

class ContentListWidgetWebsiteState extends State<ContentListWidgetWebsite> {
  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<RoutingSettingsProvider>.value(
        value: widget.provider,
        child: Consumer<RoutingSettingsProvider>(
          builder: (context, provider, __) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextFieldSearch(
                  padding: EdgeInsets.zero,
                  onChange: (_) => provider.typingIntoAddManuallyTextField(),
                  hintText: 'Введите ip адрес',
                  controller: provider.rulesFieldController,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  'Введите нужный ip',
                  style: context.textTheme.bodyLarge!.copyWith(
                      color: AppColor.hintTextStyleColor, fontSize: 11),
                ),
              ),
              ButtonLong(
                title: 'Добавить',
                onTap: provider.addNew,
                enable: provider.enabledButton,
              ),
            ],
          ),
        ),
      );
}
