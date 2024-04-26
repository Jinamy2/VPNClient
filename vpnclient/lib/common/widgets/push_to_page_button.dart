import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';

class PushToPageButton extends StatelessWidget {
  const PushToPageButton({
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    required this.onTap,
    super.key,
    required this.title,
    required this.assetIcon,
  });
  final EdgeInsets padding;
  final VoidCallback onTap;
  final String title;
  final String assetIcon;
  @override
  Widget build(BuildContext context) => Padding(
        padding: padding,
        child: GestureDetector(
          onTap: onTap,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColor.mainPurple,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: SizedBox(
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 10),
                        child: SvgPicture.asset(
                          assetIcon,
                          width: 18,
                          height: 18,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcATop,
                          ),
                        ),
                      ),
                      Text(
                        title,
                        style: context.textTheme.headlineSmall!.copyWith(
                          fontSize: 14,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: SvgPicture.asset(
                      'assets/arrow.svg',
                      width: 12,
                      height: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
