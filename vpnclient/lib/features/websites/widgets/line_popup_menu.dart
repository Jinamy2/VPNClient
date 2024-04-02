import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';

class LinePopupMenu<T> extends PopupMenuEntry<T> {
  const LinePopupMenu({
    super.key,
    required this.onTap,
    required this.title,
    required this.value,
    this.assetIcon = 'assets/point.svg',
    this.enable = true,
    this.height = kMinInteractiveDimension,
  });

  final VoidCallback onTap;
  final String title;
  final T value;
  final String assetIcon;
  final bool enable;

  @override
  final double height;

  @override
  _LinePopupMenuState<T, LinePopupMenu<T>> createState() =>
      _LinePopupMenuState<T, LinePopupMenu<T>>();

  @override
  bool represents(T? value) => value == this.value;
}

class _LinePopupMenuState<T, W extends LinePopupMenu<T>> extends State<W> {
  static const checkedTextStyle = TextStyle(
    fontFamily: 'Manrope',
    color: AppColor.mainPurple,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const uncheckedTextStyle = TextStyle(
    fontFamily: 'Manrope',
    color: Color.fromARGB(96, 128, 0, 226),
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) => PopupMenuItem(
        onTap: widget.onTap,
        value: widget.value,
        child: Column(
          children: [
            Padding(
              padding: widget.value != 'delete'
                  ? const EdgeInsets.symmetric(vertical: 10)
                  : const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  SvgPicture.asset(
                    widget.enable ? widget.assetIcon : 'assets/unckeched.svg',
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    widget.title,
                    style:
                        widget.enable ? checkedTextStyle : uncheckedTextStyle,
                  ),
                ],
              ),
            ),
            if (widget.value != 'delete') const Divider(),
          ],
        ),
      );
}
