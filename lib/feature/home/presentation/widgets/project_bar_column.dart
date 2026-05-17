import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectBarColumn extends StatelessWidget {
  const ProjectBarColumn({
    super.key,
    required this.name,
    required this.percentage,
  });

  final String name;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    final barHeight = 100.h;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '${(percentage * 100).toInt()}%',
          style: TextStyle(
            color: const Color(0xFF0A3470),
            fontWeight: FontWeight.w800,
            fontSize:14.sp,
          ),
        ),

        SizedBox(height: 16.h),

        SizedBox(
          height: barHeight,
          width: 15.w,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // ── Track ──
              Container(
                width: 28.w,
                height: barHeight,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9DD),
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),

              // ── Filled bar ──
              AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOutCubic,
                width: 28.w,
                height: barHeight * percentage,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),

                  gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xFF5B2392),
                      Color(0xFF133E87),
                      Color(0xFF3BC7E8),
                    ],
                  ),

                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFF3BC7E8),
                      blurRadius: 10,
                      spreadRadius: -2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 18.h),

        Text(
          name,
          style: TextStyle(
            color: const Color(0xFF747A87),
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
