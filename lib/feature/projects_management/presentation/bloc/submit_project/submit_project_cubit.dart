import 'package:bridge_x/feature/projects_management/domain/usecases/submit_project_as_complete_usecase.dart';
import 'package:bridge_x/feature/projects_management/presentation/bloc/submit_project/submit_project_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitProjectCubit extends Cubit<SubmitProjectState> {
  final SubmitProjectAsCompleteUseCase submitProjectAsCompleteUseCase;

  SubmitProjectCubit({required this.submitProjectAsCompleteUseCase})
      : super(const SubmitProjectInitial());

  Future<void> submitProject(int projectId) async {
    if (state is SubmitProjectLoading) return;

    emit(const SubmitProjectLoading());

    final result = await submitProjectAsCompleteUseCase(
      SubmitProjectAsCompleteParams(projectId: projectId),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(SubmitProjectFailure(message: failure.message)),
      (data) => emit(SubmitProjectSuccess(
        message: data.message,
        projectStatus: data.projectStatus,
      )),
    );
  }
}
