import 'paginated_entity.dart';

class PaginatedModel<T> extends PaginatedEntity<T> {
  const PaginatedModel({
    required super.items,
    required super.currentPage,
    required super.totalPages,
    required super.totalItems,
  });
}
