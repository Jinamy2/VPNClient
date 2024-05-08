import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';

class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({
    super.key,
    required this.hintText,
    this.padding = const EdgeInsets.all(20),
    required this.onChange,
    required this.controller,
  });
  final String hintText;
  final EdgeInsetsGeometry padding;
  final void Function(String) onChange;
  final TextEditingController controller;

  static const _border = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(100),
    ),
  );

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            color: AppColor.whiteColor,
          ),
          child: SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  icon: SvgPicture.asset(
                    'assets/search.svg',
                  ),
                  focusedBorder: _border.copyWith(
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: _border.copyWith(
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: AppColor.hintTextStyleColor,
                  ),
                ),
                cursorColor: Colors.black,
                style:
                    context.textTheme.bodyLarge!.copyWith(color: Colors.black),
                onChanged: onChange,
              ),
            ),
          ),
        ),
      );
}
