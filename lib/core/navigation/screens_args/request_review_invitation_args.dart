import 'package:bridge_x/feature/invitaions/domain/entities/project_invitation_entity.dart';
import 'package:bridge_x/feature/invitaions/presentation/cubit/invitaions_cubit.dart';

class RequestReviewInvitationArgs {
  final ProjectInvitationEntity invitation;
  final InvitaionsCubit cubit;

  const RequestReviewInvitationArgs({
    required this.invitation,
    required this.cubit,
  });
}
