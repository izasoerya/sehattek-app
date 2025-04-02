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

  String get uid {
    switch (this) {
      case StatusType.pending:
        return 'a1000000-0000-0000-0000-000000000001';
      case StatusType.inProgress:
        return 'a1000000-0000-0000-0000-000000000002';
      case StatusType.complete:
        return 'a1000000-0000-0000-0000-000000000003';
      case StatusType.cancel:
        return 'a1000000-0000-0000-0000-000000000004';
    }
  }

  factory StatusType.fromString(String status) {
    switch (status) {
      case 'StatusType.pending':
      case 'Pending':
        return StatusType.pending;
      case 'StatusType.inProgress':
      case 'In Progress':
        return StatusType.inProgress;
      case 'StatusType.complete':
      case 'Completed':
        return StatusType.complete;
      case 'StatusType.cancel':
      case 'Canceled':
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
