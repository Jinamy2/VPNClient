import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vpnclient/common/utils/getit_globals.dart';

class VpnWindows {
  String commandConnect =
      'Add-VpnConnection -Name "VPNClient" ` -ServerAddress "192.168.31.60" ` -TunnelType "IKEv2" ` -AuthenticationMethod "EAP" ` -EncryptionLevel "Maximum" ` -RememberCredential';

  String disconnect = 'rasdial "VPNClient" /DISCONNECT';

  String powershell = 'powershell.exe';

  Future<void> connectVPN() async {
    final user = auth.login;
    final password = auth.password;
    final String connect = 'rasdial "VPNClient" $user $password';
    final resultCreate =
        await Process.run(powershell, ['-Command', commandConnect])
            .then((_) => Process.run(powershell, ['-Command', connect]));
    debugPrint(resultCreate.stdout.toString());
    if (resultCreate.stdout.toString().contains('703')) {
      throw Exception('first time');
    }
  }

  Future<void> disconnectVPN() async {
    final resultDelete =
        await Process.run(powershell, ['-Command', disconnect]);
    debugPrint(resultDelete.stdout.toString());
  }
}
