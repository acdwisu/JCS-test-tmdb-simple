import 'package:jcs_test/models/paginated-data.dart';

class PaginatedDataRangedTime<T> extends PaginatedData<T> {
  final String maximumDate;
  final String minimumDate;

  PaginatedDataRangedTime({
    required this.minimumDate,
    required this.maximumDate,
    required super.page,
    required super.data,
    required super.totalPages,
    required super.totalResults,
  });
}
