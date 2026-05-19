import 'package:flutter/material.dart';

class NotificationsDetailsArgs {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String time;

  NotificationsDetailsArgs({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.time,
  });
}
