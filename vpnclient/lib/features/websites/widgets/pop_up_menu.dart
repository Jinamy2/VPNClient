import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/features/websites/widgets/line_popup_menu.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({
    super.key,
    required this.type,
    required this.onChange,
    required this.onDelete,
  });

  final String type;
  final void Function(String) onChange;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) => PopupMenuButton<String>(
        constraints: const BoxConstraints(maxWidth: 230),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        color: AppColor.whiteColor,
        icon: SvgPicture.asset('assets/points.svg'),
        onSelected: (value) {},
        itemBuilder: (BuildContext context) => [
          LinePopupMenu(
            onTap: () => onChange('direct'),
            enable: type == 'direct',
            title: 'Прямое соединение',
            value: 'direct',
          ),
          LinePopupMenu(
            onTap: () => onChange('block'),
            enable: type == 'block',
            title: 'Блокировать',
            value: 'block',
          ),
          LinePopupMenu(
            onTap: onDelete,
            title: 'Удалить',
            value: 'delete',
            assetIcon: 'assets/delete_icon.svg',
          ),
        ],
      );
}
