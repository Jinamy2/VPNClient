import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ikev2_dart/ikev2_dart_platform_interface.dart';
import 'package:ikev2_dart/models/vpn_state.dart';
import 'package:vpnclient/common/utils/getit_globals.dart';

class VpnProvider extends ChangeNotifier {
  VpnProvider() {
    Ikev2DartPlatform.instance.currentState.then((s) {
      state = s;
      notifyListeners();
    });
    Ikev2DartPlatform.instance.setVpnStateChangeHandler(updateVpnState);
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
        state == FlutterVpnState.connecting) {
      notifyListeners();
      return disconnectVPN();
    }
    return Ikev2DartPlatform.instance.connectIkev2EAP(
      server: '192.168.31.60',
      username: auth.login,
      password: auth.password,
    );
  }

  Future<void> disconnectVPN() => Ikev2DartPlatform.instance.disconnect();
}
