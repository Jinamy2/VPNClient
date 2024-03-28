import 'package:flutter/material.dart';
import 'package:ikev2_dart/models/vpn_state.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/extensions_app.dart';

class VpnStatusText extends StatelessWidget {
  const VpnStatusText({
    super.key,
    //required this.onTap,
    required this.status,
  });

  // final VoidCallback onTap;
  final FlutterVpnState status;

  Color get getTextColor => switch (status) {
        FlutterVpnState.connected => AppColor.vpnOnStatusColor,
        FlutterVpnState.disconnected => AppColor.shadowVpnControlleButtonColor,
        FlutterVpnState.connecting => AppColor.mainPurple,
        FlutterVpnState.disconnecting => AppColor.mainPurple,
        FlutterVpnState.error => AppColor.errorColor,
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
