sealed class JcException implements Exception {}

base class JcPlatformException implements JcException {
  JcPlatformException([this.message]);
  final Object? message;

  @override
  String toString() {
    final message = this.message;
    if (message == null) return 'JcException';
    return 'JcException: $message';
  }
}
