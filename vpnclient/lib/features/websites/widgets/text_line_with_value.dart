import 'package:flutter/material.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';

class TextLine extends StatelessWidget {
  const TextLine({
    super.key,
    this.actions = const [],
    required this.title,
    required this.value,
    this.valueTextStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Manrope',
      color: AppColor.getPermissionStatusColor,
    ),
    this.titleTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Manrope',
      color: AppColor.getPermissionStatusColor,
    ),
  });

  final String title;
  final List<Widget> actions;
  final String value;
  final TextStyle valueTextStyle;
  final TextStyle titleTextStyle;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: titleTextStyle,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      value,
                      style: valueTextStyle,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions.isNotEmpty
                    ? actions
                    : [
                        const SizedBox.shrink(),
                      ],
              ),
            ],
          ),
          const Divider(),
        ],
      );
}
