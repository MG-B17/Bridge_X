import 'package:bridge_x/core/utils/enum/track_experience_level_enum.dart';

class CompleteProfileEntity {
  final String track;
  final TrackExperienceLevel trackExperienceLevel;

  CompleteProfileEntity({required this.track, required this.trackExperienceLevel});

  Map<String, dynamic> toJson() {
    return {"track": track, "experience_level": trackExperienceLevel
    };
  }
}


