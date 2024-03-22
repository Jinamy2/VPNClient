import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({
    super.key,
    required this.title,
    required this.assetIcon,
    required this.styleText,
    required this.onTap,
  });

  final String title;
  final String assetIcon;
  final TextStyle styleText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              SvgPicture.asset(assetIcon),
              const SizedBox(width: 12),
              Text(title, style: styleText),
            ],
          ),
        ),
      );
}
