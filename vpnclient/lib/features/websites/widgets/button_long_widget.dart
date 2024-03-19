import 'package:flutter/material.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';

class ButtonLong extends StatelessWidget {
  const ButtonLong({
    super.key,
    required this.title,
    required this.onTap,
    required this.enable,
  });

  final String title;
  final VoidCallback onTap;
  final bool enable;

  @override
  Widget build(BuildContext context) => TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: enable ? onTap : null,
        child: DecoratedBox(
          decoration: enable
              ? const BoxDecoration(
                  color: AppColor.mainPurple,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                )
              : const BoxDecoration(
                  backgroundBlendMode: BlendMode.dstOut,
                  color: AppColor.hintTextStyleColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
          child: SizedBox(
            height: 44,
            child: Center(
              child: Text(
                title,
                style: context.textTheme.headlineSmall,
              ),
            ),
          ),
        ),
      );
}
