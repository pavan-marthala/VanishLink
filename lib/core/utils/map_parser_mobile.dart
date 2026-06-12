Map<String, dynamic>? safeMapCast(dynamic value) {
  if (value == null) return null;
  if (value is Map) {
    return Map<String, dynamic>.from(value.map(
      (k, v) => MapEntry(k.toString(), v),
    ));
  }
  return null;
}
