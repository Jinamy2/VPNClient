import 'package:flutter/material.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';
import 'package:vpnclient/features/websites/widgets/pop_up_menu.dart';
import 'package:vpnclient/features/websites/widgets/text_line_with_value.dart';

class WebsitesListView extends StatelessWidget {
  const WebsitesListView({
    super.key,
    required this.title,
    required this.ruleType,
    required this.onChange,
    required this.onDelete,
  });
  final String title;
  final String ruleType;
  final void Function(String) onChange;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          TextLine(
            title: title,
            value: ruleType,
            actions: [
              PopupMenu(
                type: ruleType,
                onChange: onChange,
                onDelete: onDelete,
              ),
            ],
            valueTextStyle: context.textTheme.bodyLarge!
                .copyWith(color: AppColor.hintTextStyleColor),
            titleTextStyle: context.textTheme.headlineSmall!.copyWith(
              fontSize: 14,
              color: AppColor.getPermissionStatusColor,
            ),
          ),
        ],
      );
}
