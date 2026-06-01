class CreateTeamMapper {
  static String mapCategoryIndexToString(int index) {
    switch (index) {
      case 0:
        return "Development";
      case 1:
        return "Design";
      case 2:
        return "Marketing";
      default:
        return "Research";
    }
  }

  static List<String> mapSelectedRoles(List<String> roles) {
    return roles.map((role) {
      final lower = role.toLowerCase().trim();

      if (lower.contains('frontend')) {
        return 'frontend';
      } else if (lower.contains('backend')) {
        return 'backend';
      } else if (lower.contains('ux') || lower.contains('ui') || lower.contains('design')) {
        return 'ui/ux';
      }

      return lower;
    }).toList();
  }
}
