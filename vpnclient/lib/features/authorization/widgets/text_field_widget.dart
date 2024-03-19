import 'package:flutter/material.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';
import 'package:vpnclient/common/utils/getit_globals.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.errorText,
    required this.keyboardType,
    required this.hintText,
    required this.onChange,
    required this.padding,
    required this.controller,
  });
  final String hintText;
  final TextInputType keyboardType;
  final EdgeInsets padding;
  final void Function(String) onChange;
  final String? errorText;
  final TextEditingController controller;

  static const _border = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(100),
    ),
  );
  @override
  Widget build(BuildContext context) => Padding(
        padding: padding.copyWith(left: 40, right: 40),
        child: Column(
          children: [
            TextField(
              onSubmitted: (value) => auth.onEnterTab(),
              controller: controller,
              cursorColor: AppColor.whiteColor,
              style: const TextStyle(color: AppColor.whiteColor),
              keyboardType: keyboardType,
              decoration: InputDecoration(
                focusedErrorBorder: _border.copyWith(
                  borderSide: const BorderSide(
                    color: AppColor.errorColor,
                  ),
                ),
                errorText: errorText != null ? '' : null,
                errorStyle: const TextStyle(height: 0.1),
                errorBorder: _border.copyWith(
                  borderSide: const BorderSide(
                    color: AppColor.errorColor,
                  ),
                ),
                enabledBorder: _border.copyWith(
                  borderSide: const BorderSide(
                    color: AppColor.whiteColor,
                  ),
                ),
                focusedBorder: _border.copyWith(
                  borderSide: const BorderSide(
                    color: AppColor.whiteColor,
                  ),
                ),
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: AppColor.hintTextStyleColor,
                  fontSize: 14,
                ),
              ),
              onChanged: onChange,
            ),
            if (errorText != null)
              Center(
                child: Text(
                  errorText!,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: AppColor.errorColor,
                    fontSize: 12,
                  ),
                ),
              )
          ],
        ),
      );
}
