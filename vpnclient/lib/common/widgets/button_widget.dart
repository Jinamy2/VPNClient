import 'package:flutter/material.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.padding = const EdgeInsets.only(bottom: 30),
    required this.title,
    required this.colorButton,
    required this.colorFont,
    required this.onTap,
    required this.enable,
    this.fontSize = 20.0,
  });
  final String title;
  final Color colorButton;
  final Color colorFont;
  final VoidCallback onTap;
  final bool enable;
  final EdgeInsets padding;
  final double fontSize;

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding,
        child: TextButton(
          onPressed: enable ? onTap : null,
          style: TextButton.styleFrom(
            disabledBackgroundColor: colorButton.withOpacity(0.2),
            disabledForegroundColor: colorFont,
            foregroundColor: colorFont,
            backgroundColor: colorButton,
            textStyle: context.textTheme.headlineSmall!
                .copyWith(fontSize: fontSize, color: colorFont),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            child: Text(title),
          ),
        ),
      );
}
