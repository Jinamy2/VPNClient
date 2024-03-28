import 'package:ikev2_dart/models/route_rule_model.dart';
import 'package:ikev2_dart/route_settings/imp/method_channe_route_settings.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class RouteSettings extends PlatformInterface {
  RouteSettings() : super(token: _token);
  static final Object _token = Object();

  static RouteSettings _instance = MethodChannelRouteSettings();

  static RouteSettings get instance => _instance;

  static set instance(RouteSettings instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List<RouteRule>> get getDefaultRouteRule =>
      throw UnimplementedError('platformVersion() has not been implemented.');

  Future<void> resetRules() =>
      throw UnimplementedError('platformVersion() has not been implemented.');

  Future<List<RouteRule>> get getAllRouteRules =>
      throw UnimplementedError('platformVersion() has not been implemented.');

  Future<void> changeTypeRouteRule(String id, RuleType type) =>
      throw UnimplementedError('platformVersion() has not been implemented.');

  Future<void> saveRouteRule(RouteRule rule) =>
      throw UnimplementedError('platformVersion() has not been implemented.');

  Future<void> deleteRouteRule(String id) =>
      throw UnimplementedError('platformVersion() has not been implemented.');
}
