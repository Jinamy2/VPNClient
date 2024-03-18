import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/features/toggle_vpn/models/vpn_state.dart';

class VpnControlleButton extends StatelessWidget {
  const VpnControlleButton({
    super.key,
    required this.onTap,
    required this.status,
  });
  final VoidCallback onTap;
  final VpnState status;

  @override
  Widget build(BuildContext context) => InkResponse(
        splashColor: AppColor.mainPurple.withOpacity(0.3),
        radius: 70,
        onTap: onTap,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            // if (status == VpnState.active)
            //   const PulseEffectWidget(), // only when active
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
            if (status == VpnState.disable)
              SvgPicture.asset(
                'assets/off_vpn.svg',
                height: 30,
                width: 30,
              ),

            if (status == VpnState.active)
              const Icon(
                Icons.check,
                size: 30,
                color: AppColor.vpnOnStatusColor,
              ),

            if (status == VpnState.noConfigFile)
              const Icon(
                Icons.settings,
                size: 30,
                color: AppColor.getPermissionStatusColor,
              ),
            if (status == VpnState.unknown)
              const Icon(
                Icons.close,
                size: 30,
                color: AppColor.errorColor,
              ),
          ],
        ),
      );
}