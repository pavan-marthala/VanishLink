import 'map_parser_mobile.dart' if (dart.library.js_util) 'map_parser_web.dart' as impl;

Map<String, dynamic>? safeMapCast(dynamic value) {
  return impl.safeMapCast(value);
}
