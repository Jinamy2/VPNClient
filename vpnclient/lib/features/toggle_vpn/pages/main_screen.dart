import 'package:flutter/material.dart';
import 'package:vpnclient/features/toggle_vpn/models/vpn_state.dart';
import 'package:vpnclient/features/toggle_vpn/widgets/push_to_websites.dart';
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
                flex: 5,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                onTap: () {},
                title: 'Сайты',
                assetIcon: 'assets/website.svg',
              ),
              PushToPageButton(
                onTap: () {},
                title: 'Настройки VPN',
                assetIcon: 'assets/settings.svg',
              ),
              const Spacer(),
            ],
          ),
        ),
      );
}
