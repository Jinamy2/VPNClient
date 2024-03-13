import 'package:flutter/material.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';
import 'package:vpnclient/features/toggle_vpn/models/vpn_state.dart';

class VpnStatusText extends StatelessWidget {
  const VpnStatusText({
    super.key,
    //required this.onTap,
    required this.status,
  });

  // final VoidCallback onTap;
  final VpnState status;

  Color get getTextColor => switch (status) {
        VpnState.active => AppColor.vpnOnStatusColor,
        VpnState.disable => AppColor.shadowVpnControlleButtonColor,
        VpnState.connecting => AppColor.mainPurple,
        VpnState.disconnecting => AppColor.mainPurple,
        VpnState.noConfigFile => AppColor.getPermissionStatusColor,
        VpnState.unknown => AppColor.errorColor,
      };

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Text(
          status.description,
          style: context.textTheme.headlineMedium!
              .copyWith(color: getTextColor, fontSize: 14),
        ),
      );
}
