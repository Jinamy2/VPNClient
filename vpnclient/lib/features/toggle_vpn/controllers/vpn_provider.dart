import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ikev2_dart/ikev2_dart_platform_interface.dart';
import 'package:ikev2_dart/models/vpn_state.dart';
import 'package:toastification/toastification.dart';
import 'package:vpnclient/common/app_constants/app_colors.dart';
import 'package:vpnclient/common/utils/getit_globals.dart';
import 'package:vpnclient/features/toggle_vpn/controllers/vpn_windows.dart';

class VpnProvider extends ChangeNotifier {
  VpnProvider() {
    if (!Platform.isWindows) {
      Ikev2DartPlatform.instance.currentState.then((s) {
        state = s;
        notifyListeners();
      });
      Ikev2DartPlatform.instance.setVpnStateChangeHandler(updateVpnState);
    }
  }
  FlutterVpnState state = FlutterVpnState.disconnected;
  CharonErrorState? charonState = CharonErrorState.NO_ERROR;

  void updateVpnState(FlutterVpnState newState) {
    state = newState;
    notifyListeners();
  }

  Future<void> toogleVPN() {
    if (Platform.isAndroid) {
      Ikev2DartPlatform.instance.prepare();
    }
    if (state == FlutterVpnState.connected ||
        state == FlutterVpnState.connecting ||
        state == FlutterVpnState.error) {
      notifyListeners();
      return disconnectVPN();
    }
    if (Platform.isWindows) {
      state = FlutterVpnState.connected;
      notifyListeners();
      final vpn = VpnWindows();
      return vpn.connectVPN().catchError((Object error) {
        if (error is Exception) {
          state = FlutterVpnState.disconnected;
          notifyListeners();
          toastification.show(
            type: ToastificationType.info,
            alignment: Alignment.bottomCenter,
            primaryColor: AppColor.mainPurple,
            style: ToastificationStyle.fillColored,
            title: const Text(
                'При первом использовании воспользуйтесь интерфейсом Windows для подключения к VPN через настройки.'),
            showProgressBar: false,
            autoCloseDuration: const Duration(seconds: 3),
          );
        }
      });
    }
    return Ikev2DartPlatform.instance.connectIkev2EAP(
      server: '192.168.31.60',
      username: auth.login,
      password: auth.password,
    );
  }

  Future<void> disconnectVPN() {
    if (Platform.isWindows) {
      state = FlutterVpnState.disconnected;
      notifyListeners();
      return VpnWindows().disconnectVPN();
    }
    return Ikev2DartPlatform.instance.disconnect();
  }
}
