import 'package:flutter/material.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/features/toggle_vpn/models/vpn_state.dart';

class ToogleVpnWidget extends StatelessWidget {
  const ToogleVpnWidget({
    super.key,
    //required this.onTap,
    //required this.status,
  });

  // final VoidCallback onTap;
  // final VpnState status;

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
          // VpnControlleButton(
          //   onTap: onTap,
          //   status: status,
          // ),
        ],
      );
}
