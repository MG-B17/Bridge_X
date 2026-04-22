import 'package:equatable/equatable.dart';

class PaginatedEntity<T> extends Equatable {
  final List<T> items;
  final int currentPage;
  final int totalPages;
  final int totalItems;

  const PaginatedEntity({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
  });

  @override
  List<Object?> get props => [items, currentPage, totalPages, totalItems];
}
