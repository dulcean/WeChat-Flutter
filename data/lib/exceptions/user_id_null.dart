class UserIdNull implements Exception {
  String errorCode;
  UserIdNull({
    required this.errorCode,
  });

  @override
  String toString() => 'UserIdNull(errorCode: $errorCode)';
}
