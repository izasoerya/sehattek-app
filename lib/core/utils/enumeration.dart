enum UserType {
  admin,
  provider,
}

enum StatusType {
  pending,
  inProgress,
  complete,
  cancel;

  String get status {
    switch (this) {
      case StatusType.pending:
        return 'Pending';
      case StatusType.inProgress:
        return 'In Progress';
      case StatusType.complete:
        return 'Completed';
      case StatusType.cancel:
        return 'Canceled';
    }
  }

  factory StatusType.fromString(String status) {
    switch (status) {
      case 'StatusType.pending':
        return StatusType.pending;
      case 'StatusType.inProgress':
        return StatusType.inProgress;
      case 'StatusType.completed':
        return StatusType.complete;
      case 'StatusType.canceled':
        return StatusType.cancel;
      default:
        throw Exception('Invalid status type: $status');
    }
  }
}

enum ErrorType {
  network,
  server,
  validation,
  unknown,
}
