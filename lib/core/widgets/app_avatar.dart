import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/extensions.dart';

class AppAvatar extends StatelessWidget {
  final String? url;
  final String fallbackName;
  final double radius;

  const AppAvatar({
    super.key,
    this.url,
    required this.fallbackName,
    this.radius = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final defaultInitials = fallbackName.isNotEmpty 
        ? fallbackName.substring(0, 1).toUpperCase() 
        : '?';

    return CircleAvatar(
      radius: radius.r,
      backgroundColor: context.colors.primary.withOpacity(0.1),
      child: url != null && url!.isNotEmpty
          ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: url!,
                width: (radius * 2).r,
                height: (radius * 2).r,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Text(
                  defaultInitials,
                  style: context.bodyLarge.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : Text(
              defaultInitials,
              style: context.bodyLarge.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
