import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ikev2_dart/ikev2_dart_platform_interface.dart';
import 'package:ikev2_dart/models/vpn_state.dart';
import 'package:isar/isar.dart';
import 'package:vpnclient/common/utils/getit_globals.dart';
import 'package:vpnclient/common/utils/isar_service.dart';
import 'package:vpnclient/features/websites/models/route_rule_isar.dart';

class RoutingSettingsProvider extends ChangeNotifier {
  RoutingSettingsProvider() {
    loadRouteRules();
  }
  // tracks changes made
  bool hasChanges = false;
  bool enabledButton = false;

  // local user rules list
  List<RouteRuleIsar> rulesList = [];
  final rulesFieldController = TextEditingController();
  late final Isar isar;

  final userWebsitesController = TextEditingController();
  bool get hasUserWebsitesSearchQuery => userWebsitesController.text.isNotEmpty;
  final userWebsitesSearchList = <RouteRuleIsar>[];
  List<RouteRuleIsar> get currentUserWebsitesList =>
      hasUserWebsitesSearchQuery ? userWebsitesSearchList : rulesList;

  Future<void> loadRouteRules() async {
    rulesList = await IsarService().getRules();
    for (final rule in rulesList) {
      await Ikev2DartPlatform.instance
          .setRuleType(rule.ip ?? rule.domen ?? '8.8.8.8', rule.ruleType!);
    }
    notifyListeners();
  }

  void searchInUserWebsites() {
    userWebsitesSearchList.clear();

    for (final e in rulesList) {
      if (searchForMatchInRouteRule(
        e,
        query: userWebsitesController.text.toLowerCase(),
      )) {
        userWebsitesSearchList.add(e);
      }
    }
    notifyListeners();
  }

  bool searchForMatchInRouteRule(RouteRuleIsar e, {required String query}) {
    if (e.domen != null) return e.domen!.toLowerCase().contains(query);
    if (e.ip != null) return e.ip!.toLowerCase().contains(query);

    return false;
  }

  bool searchMatchesInUserWebsites(String query) {
    for (final e in rulesList) {
      if (e.domen != null && e.domen! == query) {
        Fluttertoast.showToast(
          msg: 'Уже в вашем списке!',
        );
        return true;
      }
      if (e.ip != null && e.ip! == query) {
        Fluttertoast.showToast(
          msg: 'Уже в вашем списке!',
        );
        return true;
      }
    }
    return false;
  }

  // need this to update state
  void typingIntoAddManuallyTextField() {
    enabledButton = true;
    notifyListeners();
  }

  Future<void> addNew() async {
    // We can add new rule based on string you've provded, otherwise just try and grab stuff form rulesFieldController
    final domainToAdd = rulesFieldController.text;
    // can't allow to continue cause there's nothing to add
    if (domainToAdd.isEmpty) return;
    final bool alreadyInList =
        searchMatchesInUserWebsites(rulesFieldController.text);
    if (alreadyInList) {
      await Fluttertoast.showToast(
        msg: 'Уже в вашем списке!',
      );
      hasChanges = true;
      notifyListeners();
      return;
    }
    final newRule = RouteRuleIsar.generateNew(domainToAdd);
    rulesFieldController.clear();
    enabledButton = false;
    rulesList.add(newRule);
    await IsarService().addNewRule(newRule);
    await Ikev2DartPlatform.instance
        .setRuleType(domainToAdd, newRule.ruleType!);
    hasChanges = true;
    notifyListeners();
  }

  // set either to direct or block connection type
  Future<void> changeRoutingType(int id, String type) async {
    final String oldType = type == 'direct' ? 'block' : 'direct';

    await Ikev2DartPlatform.instance.deleteRuleType(
      rulesList.firstWhere((e) => e.id == id).domen ??
          rulesList.firstWhere((e) => e.id == id).ip ??
          '8.8.8.8',
      oldType,
    );
    await Ikev2DartPlatform.instance.setRuleType(
      rulesList.firstWhere((e) => e.id == id).domen ??
          rulesList.firstWhere((e) => e.id == id).ip ??
          '8.8.8.8',
      type,
    );
    rulesList.firstWhere((e) => e.id == id).ruleType = type;
    await IsarService()
        .updateRuleType(id, rulesList.firstWhere((e) => e.id == id));
    hasChanges = true;
    notifyListeners();
  }

  // remove rule from lists
  Future<void> delete(int id, String domain) async {
    await Ikev2DartPlatform.instance.deleteRuleType(
      domain,
      rulesList.firstWhere((element) => element.id == id).ruleType!,
    );
    rulesList.remove(rulesList.firstWhere((element) => element.id == id));
    await IsarService().deleteRouteRule(id);
    hasChanges = true;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    enabledButton = false;

    // get vpn state
    // if on and there's changes -  turn off then on again to apply changes
    FlutterVpnState state = FlutterVpnState.error;
    Ikev2DartPlatform.instance.currentState
        .then((value) => state = value)
        .then((_) {
      if (state == FlutterVpnState.connected && hasChanges) {
        Ikev2DartPlatform.instance.disconnect().then(
              (_) => Future.delayed(
                const Duration(seconds: 1),
                () => Ikev2DartPlatform.instance.connectIkev2EAP(
                  server: '192.168.31.60',
                  username: auth.login,
                  password: auth.password,
                ),
              ),
            );
      }
    });
  }
}
