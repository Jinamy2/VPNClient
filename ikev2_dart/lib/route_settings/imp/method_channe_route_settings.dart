import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ikev2_dart/models/route_rule_model.dart';
import 'package:ikev2_dart/route_settings/route_settings.dart';

class MethodChannelRouteSettings extends RouteSettings {
  @visibleForTesting
  final methodChannel = const MethodChannel('route_settings');

  Iterable<String>? _toFilteredStringIterable(List<Object?>? value) => value
      ?.where((element) =>
          element is String &&
          !(element.contains('domain:money.payfaraway.ru') ||
              element.contains('geoip:private') ||
              element.contains('geosite:telegram') ||
              element.contains('geoip:telegram')))
      .cast<String>();

  @override
  Future<List<RouteRule>> get getDefaultRouteRule =>
      methodChannel.invokeMethod<List<Object?>>('getDefaultRouteRule').then(
        (value) {
          final rawRouteRuleList = _toFilteredStringIterable(value);

          if (rawRouteRuleList?.isEmpty ?? true) {
            return [];
          } else {
            return rawRouteRuleList!.map(RouteRule.fromRawJson).toList();
          }
        },
      );

  @override
  Future<void> resetRules() => methodChannel.invokeMethod('resetRouteRule');

  @override
  Future<List<RouteRule>> get getAllRouteRules =>
      methodChannel.invokeMethod<List<Object?>>('getAllRouteRules').then(
        (value) {
          final rawRouteRuleList = _toFilteredStringIterable(value);
          if (rawRouteRuleList?.isEmpty ?? true) {
            return [];
          } else {
            return rawRouteRuleList!.map(RouteRule.fromRawJson).toList();
          }
        },
      );

  @override
  Future<void> changeTypeRouteRule(String id, RuleType type) =>
      methodChannel.invokeMethod(
        'changetypeRouteRule',
        {'id': id, 'newType': type.name},
      );

  @override
  Future<void> saveRouteRule(RouteRule rule) =>
      methodChannel.invokeMethod('saveRouteRule', rule.toRawJson());

  @override
  Future<void> deleteRouteRule(String id) =>
      methodChannel.invokeMethod('deleteRouteRule', id);
}
