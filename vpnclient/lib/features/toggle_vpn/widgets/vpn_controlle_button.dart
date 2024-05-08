import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ikev2_dart/models/vpn_state.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';

class VpnControlleButton extends StatelessWidget {
  const VpnControlleButton({
    super.key,
    required this.onTap,
    required this.status,
  });
  final VoidCallback onTap;
  final FlutterVpnState status;

  @override
  Widget build(BuildContext context) => InkResponse(
        splashColor: AppColor.mainPurple.withOpacity(0.3),
        radius: 70,
        onTap: onTap,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15.0,
                    spreadRadius: 10.0,
                    color: AppColor.shadowVpnControlleButtonColor,
                  ),
                ],
              ),
              child: SizedBox(
                width: 140.0,
                height: 140.0,
              ),
            ),
            if (status == FlutterVpnState.disconnected)
              SvgPicture.asset(
                'assets/off_vpn.svg',
                height: 30,
                width: 30,
              ),
            if (status == FlutterVpnState.disconnecting ||
                status == FlutterVpnState.connecting)
              SvgPicture.asset(
                'assets/load.svg',
                height: 30,
                width: 30,
                colorFilter: const ColorFilter.mode(
                  AppColor.mainPurple,
                  BlendMode.srcATop,
                ),
              ),
            if (status == FlutterVpnState.connected)
              const Icon(
                Icons.check,
                size: 30,
                color: AppColor.vpnOnStatusColor,
              ),
            if (status == FlutterVpnState.error)
              const Icon(
                Icons.close,
                size: 30,
                color: AppColor.errorColor,
              ),
          ],
        ),
      );
}
