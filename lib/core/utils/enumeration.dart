import 'package:sehattek_app/core/utils/status_detail.dart';

enum UserType {
  admin,
  provider,
}

enum StatusType {
  pending,
  inProgress,
  complete,
  cancel;

  StatusDetail get detail {
    switch (this) {
      case StatusType.pending:
        return StatusDetail(
          uid: 'a1000000-0000-0000-0000-000000000001',
          type: 'pending',
          detailInfo: 'Service is pending',
          createdAt: DateTime.now(), // Replace with actual timestamp if needed
        );
      case StatusType.inProgress:
        return StatusDetail(
          uid: 'a1000000-0000-0000-0000-000000000002',
          type: 'inProgress',
          detailInfo: 'Service is currently in progress',
          createdAt: DateTime.now(),
        );
      case StatusType.complete:
        return StatusDetail(
          uid: 'a1000000-0000-0000-0000-000000000003',
          type: 'complete',
          detailInfo: 'Service completed successfully',
          createdAt: DateTime.now(),
        );
      case StatusType.cancel:
        return StatusDetail(
          uid: 'a1000000-0000-0000-0000-000000000004',
          type: 'cancel',
          detailInfo: 'Service was cancelled',
          createdAt: DateTime.now(),
        );
    }
  }
}

enum ErrorType {
  network,
  server,
  validation,
  unknown,
}
