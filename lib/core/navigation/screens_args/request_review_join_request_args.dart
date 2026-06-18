import 'package:bridge_x/feature/invitaions/domain/entities/join_request_entity.dart';
import 'package:bridge_x/feature/invitaions/presentation/cubit/invitaions_cubit.dart';

class RequestReviewJoinRequestArgs {
  final JoinRequestEntity joinRequest;
  final InvitaionsCubit cubit;

  const RequestReviewJoinRequestArgs({
    required this.joinRequest,
    required this.cubit,
  });
}
