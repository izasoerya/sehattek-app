import 'package:sehattek_app/core/utils/enumeration.dart';
import 'package:sehattek_app/ddd/domain/entities/entities_service_product.dart';

class ErrorWrapper {
  final String message;
  final ErrorType? type;
  final EntitiesServiceProduct? data;

  ErrorWrapper({required this.message, required this.type, this.data});
}
