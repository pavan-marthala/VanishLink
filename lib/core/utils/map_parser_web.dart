// ignore_for_file: avoid_web_libraries_in_flutter, uri_does_not_exist
import 'dart:convert';
import 'dart:js_util' as js_util;

Map<String, dynamic>? safeMapCast(dynamic value) {
  if (value == null) return null;
  if (value is Map) {
    return Map<String, dynamic>.from(value.map(
      (k, v) => MapEntry(k.toString(), v),
    ));
  }
  try {
    final jsonObj = js_util.getProperty(js_util.globalThis, 'JSON');
    final jsonString = js_util.callMethod(jsonObj, 'stringify', [value]) as String?;
    if (jsonString != null) {
      return Map<String, dynamic>.from(jsonDecode(jsonString) as Map);
    }
  } catch (_) {}
  return null;
}
