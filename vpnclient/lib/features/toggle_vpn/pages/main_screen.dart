import 'package:flutter/material.dart';
import 'package:vpnclient/features/toggle_vpn/widgets/toggle_vpn_widget.dart';
import 'package:vpnclient/features/toggle_vpn/widgets/vpn_status_text.dart';
import 'package:vpnclient/features/toggle_vpn/models/vpn_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToogleVpnWidget(),
              VpnStatusText(
                status: VpnState.active,
                //TODO change status with provider
              ),
            ],
          ),
        ),
      );
}
