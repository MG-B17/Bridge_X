import 'package:bridge_x/core/utils/enum/auth_enum.dart';
import 'package:bridge_x/feature/auth/presentation/controller/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit({required this.authCubit})
      : super(const CompleteProfileState());

  final AuthCubit authCubit;

  static const List<Map<String, dynamic>> tracks = [
    {'label': 'Frontend'},
    {'label': 'UI/UX'},
    {'label': 'DevOps'},
    {'label': 'Data science'},
    {'label': 'Backend'},
    {'label': 'AI'},
    {'label': 'Mobile'},
  ];

  void selectTrack(int index) {
    emit(state.copyWith(selectedTrackIndex: index));
  }

  void selectExperience(String experience) {
    emit(state.copyWith(selectedExperience: experience));
  }

  Future<void> submitProfile() async {
    if (state.selectedTrackIndex == -1) return;
    if (authCubit.state.status == AuthStatus.loading &&
        authCubit.state.action == AuthAction.completeProfile) {
      return;
    }

    final track = tracks[state.selectedTrackIndex]['label'] as String;
    final experience = state.selectedExperience.toLowerCase();

    authCubit.completeProfile(track: track, experienceLevel: experience);
  }
}
