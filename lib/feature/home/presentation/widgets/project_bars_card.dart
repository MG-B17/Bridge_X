import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/theme/bridge_x_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'project_bar_column.dart';

class ProjectBarsCard extends StatelessWidget {
  const ProjectBarsCard({super.key});

  static const _projects = [
    _ProjectData(name: 'FinTrack', percentage: 0.90),
    _ProjectData(name: 'Graduation', percentage: 0.70),
    _ProjectData(name: 'EcoMarket', percentage: 0.40),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        24.w,
        24.h,
        24.w,
        18.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),

        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFF8FBFF),
            const Color(0xFFF4FAFF),
            const Color(0xFFEFF8FF),
          ],
          stops: const [0.0, 0.6, 1.0],
        ),

        border: Border.all(
          color: const Color(0xFF8BAFFF).withValues(alpha: 0.25),
        ),

        boxShadow: [
          BoxShadow(
            color: const Color(0xFF80BBFF).withValues(alpha: 0.10),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Stack(
        children: [
          // ── Floating glow particles ──
          ...List.generate(
            10,
            (index) => Positioned(
              top: (index * 24).toDouble(),
              left: (index * 31).toDouble(),
              child: Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF9CEBFF).withValues(alpha: 0.55),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF9CEBFF).withValues(alpha: 0.40),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Column(
            children: [
              SizedBox(
                height: 170.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: _projects.map((project) {
                    return ProjectBarColumn(
                      name: project.name,
                      percentage: project.percentage,
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 18.h),

              Text(
                AppStrings.basedOnCompleted,
                style: AppTextStyles.labelSmall.copyWith(
                  color: const Color(0xFF7A7F8C),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProjectData {
  const _ProjectData({
    required this.name,
    required this.percentage,
  });

  final String name;
  final double percentage;
}