import 'package:equatable/equatable.dart';

class AttachmentEntity extends Equatable {
  final int id;
  final String name;
  final String? url;
  final String? type;

  const AttachmentEntity({
    required this.id,
    required this.name,
    this.url,
    this.type,
  });

  @override
  List<Object?> get props => [id, name, url, type];
}
