import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bridgex/core/utils/extensions.dart';

class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double radius;

  const AppAvatar({
    super.key,
    this.imageUrl,
    required this.name,
    this.radius = 20,
  });

  String get _initials {
    if (name.isEmpty) return '?';
    final parts = name.trim().split(' ');
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final double size = radius * 2.r;

    return ClipOval(
      child: Container(
        width: size,
        height: size,
        color: context.colors.primaryLight.withOpacity(0.2),
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => _buildInitials(context),
                errorWidget: (context, url, error) => _buildInitials(context),
              )
            : _buildInitials(context),
      ),
    );
  }

  Widget _buildInitials(BuildContext context) {
    return Center(
      child: Text(
        _initials,
        style: context.bodyMedium.copyWith(
          color: context.colors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
