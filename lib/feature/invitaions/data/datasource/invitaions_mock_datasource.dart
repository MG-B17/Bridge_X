import 'package:bridge_x/feature/invitaions/domain/entities/project_invitation_entity.dart';
import 'package:bridge_x/feature/invitaions/domain/entities/join_request_entity.dart';
import 'package:bridge_x/feature/invitaions/presentation/utils/invitaions_strings.dart';

class InvitaionsMockDataSource {
  final List<ProjectInvitationEntity> _invitations = [
    const ProjectInvitationEntity(
      id: '1',
      projectName: 'FinTrack Mobile Pro',
      projectType: 'Development',
      status: 'Active',
      membersCount: '8',
      creatorName: 'Sarah Jenkins',
      description: InvitaionsStrings.finTrackMobileProDesc,
      leaderName: 'Sarah Jenkins',
      roleName: 'Lead Designer',
      memberAvatars: [
        'https://i.pravatar.cc/150?img=32',
        'https://i.pravatar.cc/150?img=33',
        'https://i.pravatar.cc/150?img=34',
        'https://i.pravatar.cc/150?img=35',
        'https://i.pravatar.cc/150?img=36',
      ],
    ),
    const ProjectInvitationEntity(
      id: '2',
      projectName: 'FinTrack Core',
      projectType: 'Asset Management Project',
      status: 'Active',
      membersCount: '4',
      creatorName: 'Sarah Chen',
      description: InvitaionsStrings.finTrackCoreDesc,
      leaderName: 'Sarah Chen',
      roleName: 'UI/UX Designer',
      memberAvatars: [
        'https://i.pravatar.cc/150?img=40',
        'https://i.pravatar.cc/150?img=41',
      ],
    ),
    const ProjectInvitationEntity(
      id: '3',
      projectName: 'EcoMarket',
      projectType: 'Sustainability Feed Project',
      status: 'Active',
      membersCount: '6',
      creatorName: 'Ahmed Ali',
      description: InvitaionsStrings.ecoMarketDesc,
      leaderName: 'Ahmed Ali',
      roleName: 'Product Designer',
      memberAvatars: [
        'https://i.pravatar.cc/150?img=60',
      ],
    ),
  ];

  final List<JoinRequestEntity> _joinRequests = [
    const JoinRequestEntity(
      id: 'r1',
      userName: 'Ahmed Ali',
      userHandle: '@marcor',
      userRole: 'Backend Engineer',
      userRating: 4.8,
      userAvatar: 'https://i.pravatar.cc/150?img=68',
      expertiseTags: ['Node.js', 'Go', 'Redis'],
      aboutText: InvitaionsStrings.ahmedAliAbout,
      appliedTimeAgo: '2 days ago',
      isNew: true,
    ),
    const JoinRequestEntity(
      id: 'r2',
      userName: 'Lina Omar',
      userHandle: '@lina',
      userRole: 'Data Analyst',
      userRating: 4.5,
      userAvatar: 'https://i.pravatar.cc/150?img=49',
      expertiseTags: ['Python', 'SQL', 'Tableau', 'PowerBI'],
      aboutText: InvitaionsStrings.linaOmarRequestDesc,
      appliedTimeAgo: '3 days ago',
      isNew: false,
    ),
  ];

  Future<List<ProjectInvitationEntity>> getInvitations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_invitations);
  }

  Future<List<JoinRequestEntity>> getJoinRequests() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_joinRequests);
  }

  Future<void> removeInvitation(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _invitations.removeWhere((e) => e.id == id);
  }

  Future<void> removeJoinRequest(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _joinRequests.removeWhere((e) => e.id == id);
  }
}
