import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollCubit extends Cubit<ScrollState> {
  ScrollCubit() : super(ScrollState(showNavbar: true));

  void hide() {
    if (state.showNavbar == false) return;
    emit(ScrollState(showNavbar: false));
  }

  void show() {
    if (state.showNavbar == true) return;
    emit(ScrollState(showNavbar: true));
  }
}
