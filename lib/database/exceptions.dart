class FireStoreException implements Exception {
  final String message;
  final String? devDetails;
  final String? prettyDetails;

  FireStoreException({
    required this.message,
    this.devDetails,
    this.prettyDetails,
  });

  @override
  String toString() {
    return 'FireStoreException : $message ${devDetails != null ? '- $devDetails' : ''}';
  }
}
