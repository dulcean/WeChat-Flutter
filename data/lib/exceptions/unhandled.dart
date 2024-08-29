class Unhandled implements Exception {
  String errorCode;
  Unhandled({
    required this.errorCode,
  });

  @override
  String toString() => 'Unhandled(errorCode: $errorCode)';
}
