import 'package:flutter/material.dart';
import 'package:vpnclient/common/app_constants/app_routes.dart';
import 'package:vpnclient/common/widgets/push_to_page_button.dart';
import 'package:vpnclient/features/toggle_vpn/models/vpn_state.dart';
import 'package:vpnclient/features/toggle_vpn/widgets/toggle_vpn_widget.dart';
import 'package:vpnclient/features/toggle_vpn/widgets/vpn_status_text.dart';

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
              const Spacer(
                flex: 2,
              ),
              ToogleVpnWidget(onTap: () {}, status: VpnState.disable),
              const VpnStatusText(
                status: VpnState.disable,
                //TODO change status with provider
              ),
              const Spacer(
                flex: 2,
              ),
              //TODO add onTap function
              PushToPageButton(
                onTap: () => Navigator.of(context).pushNamed(Routes.settings),
                title: 'Настройки VPN',
                assetIcon: 'assets/settings.svg',
              ),
              const Spacer(),
            ],
          ),
        ),
      );
}
