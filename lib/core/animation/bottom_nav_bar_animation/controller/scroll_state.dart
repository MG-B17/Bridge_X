import 'package:equatable/equatable.dart';

class ScrollState extends Equatable {
  final bool showNavbar;

  const ScrollState({required this.showNavbar});

  @override
  List<Object?> get props => [showNavbar];
}
