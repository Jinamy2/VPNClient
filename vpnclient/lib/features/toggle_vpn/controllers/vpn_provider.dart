import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ikev2_dart/ikev2_dart_platform_interface.dart';
import 'package:ikev2_dart/models/vpn_state.dart';
import 'package:vpnclient/common/utils/getit_globals.dart';

class VpnProvider extends ChangeNotifier {
  FlutterVpnState state = FlutterVpnState.disconnected;
  CharonErrorState? charonState = CharonErrorState.NO_ERROR;
  Timer? _timer;

  Future<void> toogleVPN() {
    if (!isPrepared()) Ikev2DartPlatform.instance.prepare();
    _timer = Timer(
      const Duration(milliseconds: 50),
      () {
        Ikev2DartPlatform.instance.currentState.then((s) => state = s);
        notifyListeners();
      },
    );
    if (state == FlutterVpnState.connected) {
      state = FlutterVpnState.disconnected;
      notifyListeners();
      return disconnectVPN();
    }
    return Ikev2DartPlatform.instance.connectIkev2EAP(
      server: '192.168.31.60',
      username: auth.login,
      password: auth.password,
    );
  }

  Future<void> disconnectVPN() {
    _timer?.cancel();
    _timer = null;
    return Ikev2DartPlatform.instance.disconnect();
  }

  bool isPrepared() {
    bool isPrepared = false;
    Ikev2DartPlatform.instance.prepared.then((value) => isPrepared = value);
    return isPrepared;
  }
}
