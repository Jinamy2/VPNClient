import 'dart:convert';
import 'package:uuid/uuid.dart';

class RouteRule {
  RouteRule({
    required this.id,
    required this.domain,
    required this.ip,
    required this.ruleType,
  });
  // : assert(domain == null && ip == null,
  //           'Neither domain nor ip is filled for this rule!');
  // this assert will block opening websites page and there will be no way to remove faulty rule from the list

  factory RouteRule.fromRawJson(String str) =>
      RouteRule.fromJson(json.decode(str) as Map<String, dynamic>);

  factory RouteRule.fromJson(Map<String, dynamic> json) => RouteRule(
        id: json['id'] as String,
        domain: json['domain'] as String?,
        ip: json['ip'] as String?,
        ruleType: ruleTypeFromString(json['ruleType'] as String),
      );

  factory RouteRule.generateNew(String domain) {
    const urlPattern = r'^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}\\/?[0-9]*$';
    final match = RegExp(urlPattern, caseSensitive: false).firstMatch(domain);
    final validIP = match != null || domain.contains('geoip:');

    return RouteRule(
      id: giveUUID(domain),
      domain: validIP ? null : domain,
      ip: validIP ? domain : null,
      ruleType: RuleType.DIRECT,
    );
  }
  final String id;
  final String? domain;
  final String? ip;
  RuleType ruleType;

  static String giveUUID(String path) =>
      const Uuid().v5(Uuid.NAMESPACE_URL, path);

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'domain': domain,
        'ip': ip,
        'ruleType': ruleTypeToString(ruleType),
      };

  @override
  String toString() =>
      'RouteRule: id: $id, domain: $domain, ip: $ip, ruleType: $ruleType';
}

enum RuleType {
  BLOCK,
  DIRECT,
}

RuleType ruleTypeFromString(String value) {
  switch (value) {
    case 'BLOCK':
      return RuleType.BLOCK;
    case 'DIRECT':
      return RuleType.DIRECT;
    default:
      throw ArgumentError('Invalid value for RuleType: $value');
  }
}

String ruleTypeToString(RuleType ruleType) =>
    ruleType.toString().split('.').last;
