import 'package:flutter/material.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/features/toggle_vpn/models/vpn_state.dart';
import 'package:vpnclient/features/toggle_vpn/widgets/vpn_controlle_button.dart';

class ToogleVpnWidget extends StatelessWidget {
  const ToogleVpnWidget({
    super.key,
    required this.onTap,
    required this.status,
  });

  final VoidCallback onTap;
  final VpnState status;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              color: AppColor.mainPurple,
              shape: BoxShape.circle,
            ),
            child: SizedBox(
              width: 220.0,
              height: 220.0,
            ),
          ),
          VpnControlleButton(
            status: status,
            onTap: () {},
          ),
        ],
      );
}
