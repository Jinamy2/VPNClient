import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vpnclient/features/websites/models/route_rule_isar.dart';

class IsarService {
  IsarService() {
    db = openDB();
  }
  late Future<Isar> db;

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      final isar = await Isar.open(
        [RouteRuleIsarSchema],
        directory: dir.path,
      );

      return isar;
    }

    return Future.value(Isar.getInstance());
  }

  Future<void> addNewRule(RouteRuleIsar routeRuleIsar) async {
    final isar = await db;

    isar.writeTxnSync<int>(() => isar.routeRuleIsars.putSync(routeRuleIsar));
  }

  Future<List<RouteRuleIsar>> getRules() async {
    final isar = await db;
    final IsarCollection<RouteRuleIsar> routeRulesCollection =
        isar.collection<RouteRuleIsar>();

    final contacts = routeRulesCollection.where().findAll();
    await contacts.then(
      (value) => {
        for (final rule in value) {print(rule.domen ?? rule.id)},
      },
    );
    return contacts;
  }

  Future<void> updateRuleType(int id, RouteRuleIsar updatedContact) async {
    final isar = await db;

    await isar.writeTxn(() async {
      final contactToUpdate = await isar.routeRuleIsars.get(id);

      if (contactToUpdate != null) {
        await isar.routeRuleIsars.put(updatedContact);
      } else {
        print('Contact with ID not found.');
      }
    });
  }

  Future<void> deleteRouteRule(int id) async {
    final isar = await db;

    await isar.writeTxn(() async {
      final success = await isar.routeRuleIsars.delete(id);
      print('Contact deleted: $success');
    });
  }
}
