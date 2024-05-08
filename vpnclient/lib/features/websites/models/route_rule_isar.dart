import 'package:isar/isar.dart';

part 'route_rule_isar.g.dart';

@collection
@Name('RouteRuleIsar')
class RouteRuleIsar {
  RouteRuleIsar({
    this.domen,
    this.ip,
    this.ruleType,
  });
  factory RouteRuleIsar.generateNew(String domain) {
    const urlPattern = r'^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}\\/?[0-9]*$';
    final match = RegExp(urlPattern, caseSensitive: false).firstMatch(domain);
    final validIP = match != null || domain.contains('geoip:');

    return RouteRuleIsar(
      domen: validIP ? null : domain,
      ip: validIP ? domain : null,
      ruleType: 'direct',
    );
  }
  Id id = Isar.autoIncrement;

  String? ip;

  String? domen;

  String? ruleType;
}
