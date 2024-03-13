typedef JsonMap = Map<String, Object?>;
typedef JsonList = List<Object?>;

// Safety mapping from raw json\network\etc data to exact type.
sealed class JsonUtils {
  const JsonUtils._();

// ignore: no-object-declaration
  static Object? objectByKeys(JsonMap json, List<String> keys) =>
      keys.map<Object?>((k) => json[k]).whereType<Object>().firstOrNull;

  static T? isTypeOrNull<T>(Object? object) => object is T ? object : null;

  static String? isStringOrNull(Object? object) => isTypeOrNull<String>(object);

  static num? isNumOrNull(Object? object) => isTypeOrNull<num>(object);

  static bool? isBoolOrNull(Object? object) => isTypeOrNull<bool>(object);

  static JsonList? isListOrNull(Object? object) =>
      isTypeOrNull<JsonList>(object);

  static JsonMap? isMapOrNull(Object? object) => isTypeOrNull<JsonMap>(object);
}
