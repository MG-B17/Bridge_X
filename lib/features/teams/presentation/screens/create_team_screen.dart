import 'package:flutter/material.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/create_team_details.dart';
import '../widgets/create_team_selectors.dart';

class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({super.key});

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  bool isPrivate = true;
  String selectedCategory = AppStrings.development;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CreateTeamHeader(),
            VSpace(context.spacing.xxl),
            TeamTypeSelector(isPrivate: isPrivate, onChanged: (v) => setState(() => isPrivate = v)),
            VSpace(context.spacing.xl),
            const CreateTeamForm(),
            VSpace(context.spacing.xl),
            _buildSectionLabel(context, AppStrings.categorySelection),
            VSpace(context.spacing.md),
            CategorySelector(selectedCategory: selectedCategory, onChanged: (v) => setState(() => selectedCategory = v)),
            VSpace(context.spacing.xxl),
            _buildSectionLabel(context, AppStrings.requiredRoles),
            VSpace(context.spacing.md),
            const RoleSelector(),
            VSpace(context.spacing.xxl),
            const CreateTeamFooter(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: context.colors.primary),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String text) {
    return Text(text, style: context.bodyMedium.copyWith(fontWeight: FontWeight.w900, color: context.colors.textPrimary));
  }
}
