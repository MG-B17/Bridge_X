class AppStrings {
  const AppStrings._();

  // ── App ───────────────────────────────────────────────────────────────────
  static const String appName = 'Bridge X';
  static const String version = 'Version V1.0.0';

  // ── Onboarding ────────────────────────────────────────────────────────────
  static const List<String> onboardingTitles = [
    'Find Your Team',
    'Build Real Projects',
    'Grow Together',
  ];
  static const List<String> onboardingDescriptions = [
    'Join developers based on your skills and goals. Collaborative building starts here.',
    'Work on real-world projects to grow your portfolio.',
    'Learn, collaborate, and improve faster as a team.',
  ];
  static const String getStarted = 'Start';
  static const String skip = 'Skip';
  static const String next = 'Next';

  // ── Auth — General ────────────────────────────────────────────────────────
  static const String welcomeBack = 'Welcome back';
  static const String createAccount = 'Create Account';
  static const String login = 'Login';
  static const String signUp = 'Sign up';
  static const String backToLogin = 'Back to Login';
  static const String send = 'Send';
  static const String verify = 'Verify';
  static const String continueWith = 'OR CONTINUE WITH';
  static const String signUpWith = 'OR SIGN UP WITH';
  static const String noAccount = "Don't have an account? Sign up";
  static const String alreadyHaveAccount = 'Already have an account? Log in';
  static const String noAccountPrefix = "Don't have an account? ";
  static const String alreadyHaveAccountPrefix = 'Already have an account? ';
  static const String agreeTerms =
      'I agree to the Terms of Service and Privacy Policy';
  static const String agreeTermsPrefix = 'I agree to the ';
  static const String termsOfService = 'Terms of Service';
  static const String privacyPolicy = 'Privacy Policy';
  static const String andText = ' and ';

  // ── Auth — Login ──────────────────────────────────────────────────────────
  static const String loginSubtitle = 'Please enter your details to sign in';
  static const String rememberMe = 'Remember me for 30 days';
  static const String forgotPassword = 'Forgot Password?';

  // ── Auth — Form Fields ────────────────────────────────────────────────────
  static const String fullName = 'Full Name';
  static const String email = 'Email Address';
  static const String emailAddress = 'Email Address';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String newPassword = 'New Password';
  static const String confirmNewPassword = 'Confirm New Password';
  static const String currentPassword = 'Current Password';
  static const String currentPasswordHint = 'Enter current password';
  static const String newPasswordLabel = 'New Password';
  static const String newPasswordHint = 'Enter new password';
  static const String confirmNewPasswordHint = 'Confirm new password';
  static const String passwordMinLength =
      'Password must be at least 8 characters long.';
  static const String username = 'Username';
  static const String usernameHint = 'Enter username';
  static const String bio = 'Bio';
  static const String bioHint = 'Tell us about yourself...';

  // ── Auth — Hints ──────────────────────────────────────────────────────────
  static const String emailHint = 'name@gmail.com';
  static const String companyEmailHint = 'name@company.com';
  static const String passwordHint = 'Enter your password';
  static const String fullNameHint = 'Eman tweeg';

  // ── Auth — Reset Password ─────────────────────────────────────────────────
  static const String resetPassword = 'Reset Password';
  static const String sendResetLink = 'Send Reset Link';
  static const String resetDescription =
      "Enter your email address and we'll send you a link to reset your password.";

  // ── Auth — OTP / Verify ───────────────────────────────────────────────────
  static const String verifyCode = 'Verify Code';
  static const String verifyDescription =
      'Enter the 6-digit code sent to your email';
  static const String resendCode = 'Resend code in 00:30';
  static const String wrongEmail = 'Wrong email?';
  static const String updatePassword = 'Update Password';

  // ── Auth — Complete Profile ───────────────────────────────────────────────
  static const String profileSetup = 'Profile Setup';
  static const String completeProfile = 'Complete Your Profile';
  static const String selectTrack = 'Select Your Track';
  static const String experienceLevel = 'Experience Level';
  static const String required = 'Required';
  static const String continueText = 'Continue to Matching';

  // ── Tracks ────────────────────────────────────────────────────────────────
  static const String frontend = 'Frontend';
  static const String backend = 'Backend';
  static const String uiux = 'UI/UX Design';
  static const String flutter = 'Flutter';
  static const String ai = 'Artificial Intelligence';
  static const String iosAndroid = 'iOS / Android';
  static const String devOps = 'DevOps';
  static const String dataScience = 'Data Science';

  static const String frontendDesc = 'React, Vue, Web';
  static const String backendDesc = 'Node, Python, Go';
  static const String uiuxDesc = 'Figma, Adobe, UXR';
  static const String flutterDesc = 'Dart, Multiplatform';
  static const String aiDesc = 'LLM, ML, PyTorch';
  static const String iosDesc = 'Swift, Kotlin';
  static const String devOpsDesc = 'AWS, Docker, CI/CD';
  static const String dataDesc = 'Pandas, SQL, R';

  // ── Experience Levels ─────────────────────────────────────────────────────
  static const String beginner = 'Beginner';
  static const String junior = 'Junior';
  static const String senior = 'Senior';
  static const List<String> experienceLevels = [beginner, junior, senior];

  // ── Home / Dashboard ─────────────────────────────────────────────────────
  static const String journeyStart = 'Your journey starts here';
  static const String joinCreators =
      'Join 2,000+ creators building the future.';
  static const String hiGreeting = 'Hi, Ahmed 👋';
  static const String greetingSubtitle = "Let's build something great today";
  static const String tipBanner =
      'Tip: Join a team to start building real projects';
  static const String basedOnCompleted = 'Based on completed tasks';
  static const String aiInsights = 'AI Insights';
  static const String insightProductivity =
      'You completed 30% more tasks this week compared to your average.';
  static const String insightPeakTime =
      'You are most productive in the evening (6 PM - 9 PM).';
  static const String home = 'Home';
  static const String chat = 'Chat';
  static const String projects = 'Projects';
  static const String profile = 'Profile';
  static const String notifications = 'Notifications';
  static const String markAllRead = 'Mark all as read';
  static const String reload = 'Reload';
  static const String search = 'Search teams or messages...';
  static const String chats = 'Chats';
  static const String viewAll = 'View All';
  static const String details = 'Details';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String edit = 'Edit';
  static const String saveChanges = 'Save Changes';
  static const String addSkill = 'Add Skill';
  static const String logout = 'Log Out';
  static const String logoutTitle = 'Log out of Bridge X?';
  static const String logoutConfirm =
      'Are you sure you want to sign out? You will need to log back in to access your projects.';

  // ── Projects ──────────────────────────────────────────────────────────────
  static const String milestone = 'Milestone';
  static const String projectVerified = 'Project Verified';
  static const String projectLaunched = 'Project Launched';
  static const String myProjects = 'My Projects';
  static const String noProjects = 'No projects yet';
  static const String startProject =
      'Start your first project or join an existing team to begin your journey.';
  static const String exploreTeams = 'Explore Public Teams';
  static const String createProject = 'Create Project';
  static const String submitProject = 'Submit Project';
  static const String projectCompleted = 'Project Completed 🎉';
  static const String githubUrl = 'Github URL';
  static const String urlHint = 'URL';
  static const String projectDescription = 'Project Description';
  static const String describeProjectHint =
      "Describe your project goals and what you're looking to build...";
  static const String categorySelection = 'Category Selection';
  static const String marketing = 'Marketing';
  static const String research = 'Research';
  static const String business = 'Business';
  static const String requiredRoles = 'Required Roles';
  static const String addMoreHint = 'Add more...';
  static const String rolesUsageDisclaimer =
      'These roles will be used by the AI for matching.';
  static const String inviteMembersManually = 'Invite members manually';
  static const String youAreMentor = 'You are the mentor';
  static const String projectSuccessfullySubmitted =
      'You have successfully submitted this project';
  static const String reviewPendingByAdmin = 'Review pending by administration';
  static const String viewSummary = 'View Summary';
  static const String backToProjects = 'Back to Projects';
  static const String addProject = '+ Add Project';
  static const String projectName = 'Project Name';
  static const String projectNameHint = 'e.g. Portfolio Redesign';
  static const String myProjectsSubtitle =
      'Manage and track your collaboration progress';
  static const String all = 'All';
  static const String developmentPhase = 'Development Phase';
  static const String yourTeam = 'Your Team';
  static const String myRole = 'MY ROLE';
  static const String githubRepositoryLink = 'GitHub Repository Link';
  static const String viewTasks = 'View Tasks';
  static const String viewChat = 'View Chat';

  // ── Teams ─────────────────────────────────────────────────────────────────
  static const String teamMembers = 'Team Members';
  static const String teamSettings = 'Team Settings';
  static const String createTeam = 'Create Team 🚀';
  static const String createTeamSubtitle =
      'Set up your team and project details';
  static const String joinTeam = 'Join Team';
  static const String teamName = 'Team Name';
  static const String teamNameHint = 'e.g. Project Phoenix';
  static const String teamInfo = 'Team Info';
  static const String mentorAccess = 'Mentor Access';
  static const String youAreTeamLeader =
      'You are the Team Leader of this project';
  static const String teamType = 'Team Type';
  static const String private = 'Private';
  static const String privateDesc = 'You manually add team members';
  static const String public = 'Public';
  static const String publicDesc =
      'AI matches members & others can request to join';
  static const String privateTeam = 'Private Team';
  static const String privateTeamDesc = 'You manually add team members';
  static const String publicTeam = 'Public Team';
  static const String publicTeamDesc =
      'AI matches members & others can request to join';
  static const String addMember = 'Add Member';
  static const String addMembers = 'Add Members';
  static const String manageAll = 'Manage All';
  static const String teamCreatedSuccessfully = 'Team Created Successfully 🎉';
  static const String teamReadyStartCollaborating =
      'Your team is ready to start collaborating. Invite members or jump straight into your workspace to begin building.';
  static const String quickSetup = 'QUICK SETUP';
  static const String goToTeam = 'Go to Team';
  static const String backToHome = 'Back to home';
  static const String viewTeam = 'View Team';
  static const String openChat = 'Open Chat';
  static const String backToTeam = 'Back to Team';
  static const String membersManagement = 'Members Management';
  static const String assignTasks = 'Assign Tasks';
  static const String projectControl = 'Project Control';
  static const String removeTeam = 'Remove Team';
  static const String createAssignTask = 'Create / Assign Task';
  static const String noMembersInTeam = 'No members in this team.';
  static const String navigationToAssignTask =
      'Navigation to Assign Task screen';
  static const String projectCompletionSubmitted =
      'Project Completion request submitted';
  static const String removeTeamSubmitted = 'Remove Team request submitted';
  static const String submitProjectAsCompleted = 'Submit Project as Completed';
  static const String memberSettingsFor = 'Member settings for';

  // ── Tasks ─────────────────────────────────────────────────────────────────
  static const String createTask = 'Create Task';
  static const String assignTask = 'Assign Task';
  static const String taskTitle = 'Task Title';
  static const String taskDetails = 'Task Details';
  static const String tasksPending = 'Tasks Pending';
  static const String completedTasks = 'Completed Tasks';
  static const String activeTasks = 'Active Tasks';
  static const String ongoing = 'Ongoing';
  static const String completed = 'Completed';
  static const String inProgress = 'In Progress';
  static const String pending = 'Pending';
  static const String myTasks = 'My Tasks';
  static const String myTasksSubtitle =
      'Manage your daily workflow and projects';
  static const String allCaughtUp = 'All caught up!';
  static const String exploreProjects = 'Explore Projects';
  static const String active = 'Active';
  static const String nearCompletion = 'Near Completion';
  static const String progress = 'Progress';
  static const String noActiveTasks =
      "You don't have any active tasks right now.";
  static const String takeBreak = 'Take a break or find a new project.';
  static const String description = 'Description';
  static const String dueDate = 'Due Date';
  static const String createdBy = 'Created By';
  static const String attachments = 'Attachments';
  static const String updateProgress = 'Update Progress';
  static const String high = 'High';
  static const String viewTask = 'VIEW TASK';
  static const String viewAllTasks = 'View All Tasks';
  static const String todo = 'TO DO';
  static const String dueTomorrow = 'Due tomorrow';
  static const String nextSprint = 'Next sprint';
  static const String viewProjectDetails = 'View Project Details';

  // ── Productivity ──────────────────────────────────────────────────────────
  static const String yourProductivity = 'Your Productivity';
  static const String totalTasks = 'Total Tasks';
  static const String completedProjects = 'Projects Completed';
  static const String activeMembers = 'Active Members';
  static const String totalDone = 'Total Done';
  static const String thisWeek = 'This Week';
  static const String recentlyFinished = 'Recently Finished';
  static const String goalSmashed = 'Goal Smashed!';
  static const String goalSmashedDesc =
      "You've completed 20% more tasks this month than the previous one. Keep the momentum";
  static const String viewInsights = 'View Insights';
  static const String viewReport = 'View Report';
  static const String submitReport = 'Submit Report';
  static const String reportUser = 'Report User';
  static const String submitReportTitle = 'Submit report?';
  static const String submitReportDesc =
      'Are you sure you want to report this user? Our team will review the activity promptly.';
  static const String reportSubmittedDesc =
      'Our team will review your report to build trust and clarity. Thank you for helping us maintain a healthy collaboration environment.';

  // ── Profile ───────────────────────────────────────────────────────────────
  static const String editProfile = 'Edit Profile';
  static const String accountSecurity = 'ACCOUNT SECURITY';
  static const String changePassword = 'Change Password';
  static const String settings = 'Settings';
  static const String tapToUpdateAvatar = 'Tap to update avatar';
  static const String professionRole = 'Profession/Role';
  static const String available = 'Available';
  static const String bioMaxCharsHint =
      'Maximum 250 characters. Professional bio recommended.';
  static const String yourRole = 'YOUR ROLE';
  static const String uiuxDesigner = 'UI/UX Designer';
  static const String roleDescription =
      'You are responsible for design tasks in this project';
  static const String overview = 'OVERVIEW';
  static const String projectOverview =
      'Building a next-generation design system and component library using React and Tailwind CSS. Focus on accessibility and performance.';
  static const String members = 'MEMBERS';
  static const String yourTasks = 'YOUR TASKS';
  static const String role = 'Role';
  static const String roleHint = 'e.g. Lead Designer';
  static const String confirmAdd = 'Confirm Add';
  static const String skillsAndExperience = 'Skills & Experience';
  static const String completedTasksUpper = 'COMPLETED TASKS';
  static const String teamsUpper = 'TEAMS';
  static const String activeTasksUpper = 'ACTIVE TASKS';
  static const String experience = 'Experience';
  static const String experienceDesc =
      "Experienced mobile developer with a focus on creating performant, beautiful cross-platform applications. I have spent the last 3 years mastering Flutter and React, contributing to several high-profile fintech and social networking projects. I'm passionate about clean architecture and pixel-perfect UI implementation.";
  static const String skills = 'Skills';

  // ── Levels & Badges ───────────────────────────────────────────────────────
  static const String yourLevel = 'Your Level';
  static const String trackGrowth = 'Track your growth and performance';
  static const String currentTier = 'CURRENT TIER';
  static const String beginnerSilver = 'Beginner Silver';
  static const String progressToGold = 'Progress to Gold';
  static const String nextTierRequirement =
      'Next: Beginner Gold - 100 tasks remaining';
  static const String averageRating = 'Average Rating';
  static const String top5Percent = 'TOP 5%';
  static const String highActivityConsistency = 'High Activity Consistency';
  static const String performanceCalculatedAI =
      'Your performance is calculated using AI';
  static const String levelRoadmap = 'Level Roadmap';
  static const String beginnerTier = 'BEGINNER TIER';
  static const String juniorTier = 'JUNIOR TIER';
  static const String seniorTier = 'SENIOR TIER';
  static const String bronze = 'Bronze';
  static const String silver = 'Silver';
  static const String gold = 'Gold';
  static const String recent = 'RECENT';
  static const String earlier = 'EARLIER';
  static const String newBadge = 'NEW';

  // ── Notifications ─────────────────────────────────────────────────────────
  static const String youreIn = "You're in! 🎉";
  static const String acceptedIntoFrontendGuild =
      "You've been accepted into Frontend Guild";
  static const String newTaskAssigned = 'New Task Assigned';
  static const String assignedNewTask =
      "You've been assigned a new task: Design Login Screen";
  static const String newMessageInAlphaCoders =
      'New message in Alpha Coders chat';
  static const String taskUpdated = 'Task Updated';
  static const String taskStatusUpdated =
      "Your task status has been updated to 'In Progress'";
  static const String requestUpdate = 'Request Update';
  static const String requestToJoinNotApproved =
      "Your request to join 'Nexus Web' was not approved";
  static const String justNow = 'Just now';
  static const String twoHoursAgo = '2 hours ago';
  static const String today = 'Today';
  static const String viewDetails = 'View Details';
  static const String noNotifications = 'No notifications yet';
  static const String msgAuthTest = 'Authentication test message';
  static const String msgBackendComplete = 'Backend development is complete';
  static const String msgUiReply =
      'Great work! I will start integrating the frontend.';
  static const String teamAlpha = 'Team Alpha';
  static const String teamBeta = 'Team Beta';
  static const String membersOnline = '5 members online';
  static const String typeYourMessage = 'Type your message...';
  static const String searchTeamsOrMessages = 'Send Message';
  static const String recentConversations = 'Recent Conversations';
  static const String retryMatching = 'Retry Matching';
  static const String createYourOwnTeam = 'Create Your Own Team';
  static const String requestToJoin =
      "Request to join";
  static const String noTeamsFound = 'No teams found';
  static const String noTeamsFoundSubtitle =
      'We couldn\'t find any teams matching your profile. Try adjusting your preferences or create a new team to start collaborating.';
  static const String recommendedForYou = 'Recommended for you';
  // ── Matching ──────────────────────────────────────────────────────────────
  static const String matching = 'Matching';
  static const String matchingSubtitle =
      "We're finding the best teams for your skills and experience.";
  static const String optimizing = 'Optimizing';
  static const String dynamicInsight = 'Dynamic Insight';
  static const String dynamicInsightSubtitle =
      'Analyzing your experience in Frontend Development and Cloud Architecture.';
  static const String coreSkillScan = 'CORE SKILL SCAN';
  static const String matchingDot = 'Matching...';
  static const String skillsVerified = 'Skills verified successfully';
  static const String experienceAnalyzed = 'Experience analyzed';
  static const String finalizingShortlist = 'Finalizing shortlist';
  static const String selectCategory = 'Select Category';
  static const String categorySheetSubtitle =
      'Choose the type of team you want to join';
  static const String multiCategoryHint =
      'You can select multiple categories. This helps our algorithm find the best squad match for your specific skill set.';
  static const String startMatching = 'Start Matching';
  static const String matchingTitle = 'Matching you with the best teams...';
  static const String matchingSubtitleFull =
      'Analyzing your skills and experience to find the perfect professional environment.';
  static const String aiData = 'AI / Data';
  static const String tryAgain = 'Try Again';
  static const String membersLabel = 'Members';

  // ── Settings / Privacy ────────────────────────────────────────────────────
  static const String privacyAndSecurity = 'Privacy & Security';
  static const String bridgeXVersion = 'Bridge X VERSION 1.0.0';
  static const String bridgeXProtection = 'Bridge X Protection';
  static const String bridgeXProtectionDesc =
      'Manage your digital footprint and secure your collaboration environment.';
  static const String dangerZone = 'Danger Zone';
  static const String deleteAccount = 'Delete Account';
  static const String privacyDisclaimer =
      'Bridge X uses end-to-end encryption for all sensitive data transmission. Your personal information is never shared with third-party advertisers without your explicit consent. For more details, view our ';
  static const String securityUpdate = 'Security Update';
  static const String securityUpdateDesc =
      'Manage your Bridge X account security';

  // ── About ─────────────────────────────────────────────────────────────────
  static const String aboutUs = 'About Us';
  static const String aboutBridgeXDesc =
      'A platform that connects developers to collaborate on real projects.';
  static const String ourMission = 'Our Mission';
  static const String ourMissionDesc =
      'Bridging the gap between code and community through meaningful collaboration.';
  static const String madeWithLove = 'MADE WITH ❤️ FOR DEVELOPERS';

  // ── Notification Settings ─────────────────────────────────────────────────
  static const String pushNotifications = 'Push Notifications';
  static const String pushNotificationsDesc = 'Receive alerts on your device';
  static const String teamUpdates = 'Team Updates';
  static const String teamUpdatesDesc = 'Notify when a team project changes';
  static const String newMessages = 'New Messages';
  static const String newMessagesDesc = 'Alerts for new chat messages';
  static const String taskUpdates = 'Task Updates';
  static const String taskUpdatesDesc =
      'Notify when a task is assigned or updated';

  // ── Misc / Common Labels ──────────────────────────────────────────────────
  static const String development = 'Development';
  static const String design = 'Design';
  static const String success = 'Success';
  static const String error = 'Error';
  static const String noTeamMembersYet = 'No team members yet';
  static const String projectCompletion = 'Project Completion';
  static const String projectCompletionConfirmation =
      '"Are you sure you want to mark this project as completed?"';
  static const String markProjectAsCompletedDesc =
      'Mark this project as completed when all tasks are done';
  static const String youAreMentorBadge = 'YOU ARE THE MENTOR';

  // ── Error Dialog Titles ───────────────────────────────────────────────────
  static const String loginFailed = 'Login Failed';
  static const String registrationFailed = 'Registration Failed';
  static const String verificationFailed = 'Verification Failed';
  static const String requestFailed = 'Request Failed';

  // ── Create Task Screen ────────────────────────────────────────────────────
  static const String taskTitleHint = 'e.g. Implement OAuth2 flow';
  static const String assignTo = 'Assign To';
  static const String searchTeamMembers = 'Search team members...';
  static const String add = 'Add';
  static const String taskDetailsHint = 'Describe what needs to be done...';
  static const String selectDate = 'Select date';
  static const String priority = 'Priority';
  static const String priorityLow = 'LOW';
  static const String priorityMed = 'MED';
  static const String priorityHigh = 'HIGH';
  static const String tags = 'Tags';
  static const String tag = 'Tag';
  static const String addTag = 'Add Tag';
  static const String enterTagName = 'Enter tag name';
  static const String creatingTask = 'Creating task...';
  static const String taskCreated = 'Task Created!';
  static const String taskCreatedMessage = 'Task has been created successfully.';
}
