import 'dart:io';
import 'package:dio/dio.dart';

class UpdateProfileRequestModel {
  final String? fullName;
  final String? userName;
  final String? bio;
  final String? track;
  final File? avatarFile;

  const UpdateProfileRequestModel({
    this.fullName,
    this.userName,
    this.bio,
    this.track,
    this.avatarFile,
  });

  bool get hasChanges =>
      fullName != null || userName != null || bio != null || track != null || avatarFile != null;

  Future<FormData> toFormData() async {
    final map = <String, dynamic>{};

    if (fullName != null) map['full_name'] = fullName;
    if (userName != null) map['user_name'] = userName;
    if (bio != null) map['bio'] = bio;
    if (track != null) map['track'] = track;
    if (avatarFile != null) {
      map['avatar'] = await MultipartFile.fromFile(
        avatarFile!.path,
        filename: avatarFile!.path.split(Platform.pathSeparator).last,
      );
    }

    return FormData.fromMap(map);
  }
}
