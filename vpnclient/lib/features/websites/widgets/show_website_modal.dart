import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';

void showAddWebsiteModal(
  BuildContext context,
  String title,
  Widget content,
) {
  showModalBottomSheet<void>(
    context: context,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).copyWith().size.height * 0.9,
    ),
    isScrollControlled: true,
    builder: (BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 21,
                ),
                Text(
                  title,
                  style: context.textTheme.headlineLarge!
                      .copyWith(color: AppColor.mainPurple, fontSize: 18),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset('assets/close.svg'),
                ),
              ],
            ),
          ),
          Expanded(child: content),
        ],
      ),
    ),
  );
}
