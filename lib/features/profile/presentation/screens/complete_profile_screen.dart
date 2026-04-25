import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/navigation/app_route_constant.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../../../core/widgets/h_space.dart';
import '../../../../core/widgets/v_space.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  int? _selectedTrackIndex;
  int _selectedLevelIndex = 1; // Default to Junior

  final List<_TrackItem> _tracks = [
    _TrackItem(
      title: 'Frontend',
      subtitle: 'React, Vue, Web',
      icon: Icons.code_rounded,
    ),
    _TrackItem(
      title: 'Backend',
      subtitle: 'Node, Python, Go',
      icon: Icons.storage_rounded,
    ),
    _TrackItem(
      title: 'UI/UX Design',
      subtitle: 'Figma, Adobe, UXR',
      icon: Icons.auto_awesome_outlined,
    ),
    _TrackItem(
      title: 'Flutter',
      subtitle: 'Dart, Multiplatform',
      icon: Icons.flutter_dash_rounded,
    ),
    _TrackItem(
      title: 'Artificial Intel.',
      subtitle: 'LLM, ML, PyTorch',
      icon: Icons.psychology_outlined,
    ),
    _TrackItem(
      title: 'iOS / Android',
      subtitle: 'Swift, Kotlin',
      icon: Icons.smartphone_rounded,
    ),
    _TrackItem(
      title: 'DevOps',
      subtitle: 'AWS, Docker, CI/CD',
      icon: Icons.loop_rounded,
    ),
    _TrackItem(
      title: 'Data Science',
      subtitle: 'Pandas, SQL, R',
      icon: Icons.query_stats_rounded,
    ),
  ];

  final List<String> _levels = [
    AppStrings.beginner,
    AppStrings.junior,
    AppStrings.senior,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.colors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          AppStrings.profileSetup,
          style: context.titleLarge.copyWith(
            color: context.colors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VSpace(20.h),
              Text(
                AppStrings.completeProfile,
                textAlign: TextAlign.center,
                style: context.displayLarge.copyWith(
                  color: const Color(0xFF1E3A8A), // Deep blue
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              VSpace(context.spacing.xs),
              Text(
                'Help us find the right team for you.',
                style: context.bodyMedium.copyWith(
                  color: context.colors.textSecondary,
                  fontSize: 16.sp,
                ),
              ),
              VSpace(context.spacing.xxl),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.selectTrack,
                    style: context.titleLarge.copyWith(
                      color: context.colors.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDBEAFE),
                      borderRadius: BorderRadius.circular(context.spacing.radiusXs),
                    ),
                    child: Text(
                      AppStrings.required,
                      style: context.labelSmall.copyWith(
                        color: const Color(0xFF1E40AF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              VSpace(context.spacing.lg),
              
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 1.1,
                ),
                itemCount: _tracks.length,
                itemBuilder: (context, index) {
                  return _TrackCard(
                    item: _tracks[index],
                    isSelected: _selectedTrackIndex == index,
                    onTap: () => setState(() => _selectedTrackIndex = index),
                  );
                },
              ),
              
              VSpace(context.spacing.xxl),
              
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.experienceLevel,
                  style: context.titleLarge.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              VSpace(context.spacing.lg),
              
              _LevelSelector(
                levels: _levels,
                selectedIndex: _selectedLevelIndex,
                onChanged: (index) => setState(() => _selectedLevelIndex = index),
              ),
              
              VSpace(context.spacing.xxl),
              
              _GradientBanner(),
              
              VSpace(context.spacing.xxl),
              
              AppButton(
                label: 'Continue to Matching',
                onPressed: _onContinue,
                trailing: Icon(Icons.chevron_right, color: Colors.white, size: 20.w),
              ),
              VSpace(context.spacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  void _onContinue() {
    if (_selectedTrackIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your track')),
      );
      return;
    }
    context.go(AppRouteConstant.home);
  }
}

class _TrackItem {
  final String title;
  final String subtitle;
  final IconData icon;

  _TrackItem({required this.title, required this.subtitle, required this.icon});
}

class _TrackCard extends StatelessWidget {
  final _TrackItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _TrackCard({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? context.colors.primary : context.colors.divider,
            width: isSelected ? 2.w : 1.w,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: context.colors.primary.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Stack(
          children: [
            if (isSelected)
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Icon(
                  Icons.check_circle_rounded,
                  color: context.colors.primary,
                  size: 18.w,
                ),
              ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      item.icon,
                      color: const Color(0xFF1E3A8A),
                      size: 24.w,
                    ),
                  ),
                  VSpace(context.spacing.sm),
                  Text(
                    item.title,
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1E3A8A),
                    ),
                  ),
                  Text(
                    item.subtitle,
                    style: context.labelSmall.copyWith(
                      color: context.colors.textHint,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LevelSelector extends StatelessWidget {
  final List<String> levels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _LevelSelector({
    required this.levels,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing.sm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.colors.divider),
      ),
      child: Row(
        children: levels.asMap().entries.map((entry) {
          final index = entry.key;
          final level = entry.value;
          final isSelected = index == selectedIndex;
          
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => onChanged(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.transparent : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected ? context.colors.primary : Colors.transparent,
                          width: 2.w,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          level,
                          style: context.bodyMedium.copyWith(
                            color: isSelected ? const Color(0xFF1E3A8A) : context.colors.textHint,
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (index != levels.length - 1) HSpace(context.spacing.sm),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _GradientBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFDBEAFE),
            const Color(0xFF1E40AF),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your journey starts here',
            style: context.labelSmall.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
          VSpace(context.spacing.xs),
          Text(
            'Join 2,000+ creators building the future.',
            style: context.titleLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 22.sp,
            ),
          ),
        ],
      ),
    );
  }
}
