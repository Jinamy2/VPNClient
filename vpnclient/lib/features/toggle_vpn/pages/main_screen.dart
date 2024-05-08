import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpnclient/common/app_constants/app_routes.dart';
import 'package:vpnclient/common/widgets/push_to_page_button.dart';
import 'package:vpnclient/features/toggle_vpn/controllers/vpn_provider.dart';
import 'package:vpnclient/features/toggle_vpn/widgets/toggle_vpn_widget.dart';
import 'package:vpnclient/features/toggle_vpn/widgets/vpn_status_text.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<VpnProvider>.value(
        value: VpnProvider(),
        child: Scaffold(
          body: Consumer<VpnProvider>(
            builder: (context, provider, __) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  Column(
                    children: [
                      ToogleVpnWidget(
                        onTap: provider.toogleVPN,
                        status: provider.state,
                      ),
                      VpnStatusText(
                        status: provider.state,
                      ),
                    ],
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  PushToPageButton(
                    onTap: () =>
                        Navigator.of(context).pushNamed(Routes.settings),
                    title: 'Настройки VPN',
                    assetIcon: 'assets/settings.svg',
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      );
}
