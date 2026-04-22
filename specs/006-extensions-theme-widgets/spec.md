# Feature Specification: Extensions, Color Schema & Shared Widgets

## 1. Feature Description

### 1.1 Goal
Provide a unified, centralized design system access layer and a shared widget library based on the TeamUP Figma designs. This ensures all future features have immediate, consistent access to correct colors, typography, and reusable components (buttons, text fields, loaders, error states, and avatars) without duplicating code or manually importing design constants.

### 1.2 Target Audience
- **Development Team**: Allows developers to easily access theme properties and shared UI components, significantly speeding up future feature development and ensuring UI consistency.
- **End Users**: Experience a consistent, branded, and polished user interface across the entire application.

### 1.3 Business Value
Reduces technical debt, prevents UI inconsistencies, and speeds up time-to-market for future features by providing a robust foundational UI toolkit.

## 2. User Scenarios & Use Cases

### Scenario 1: Developing a new screen
When a developer creates a new screen (e.g., Login Page), they need to add a primary button, a text input field, and style text.
- **Flow**: The developer uses `AppButton`, `AppTextField`, and accesses colors and fonts via `context.colors.primary` and `context.headlineMedium`.
- **Result**: The screen is built quickly and perfectly matches the Figma design system, automatically supporting light/dark mode transitions if enabled.

### Scenario 2: Handling loading and error states
When data is being fetched or fails to load, the user must be informed.
- **Flow**: The developer displays `AppLoading` during the fetch, and `AppErrorWidget` if it fails.
- **Result**: The user sees consistent, branded loading indicators and error messages with retry options across the entire app.

## 3. Functional Requirements

### 3.1 Design System Extensions
- **Theme Extensions**: The system must provide a unified `ThemeExtension` containing all semantic color tokens defined in the Figma design system (light and dark mode values).
- **Context Access**: Developers must be able to access all colors and typography styles directly from the `BuildContext` (e.g., `context.colors.primary`, `context.bodyLarge`) without importing static color or style classes.
- **Utility Extensions**: The system must provide utility extensions on `BuildContext` for common tasks like showing a `SnackBar` and getting screen dimensions, and on `String` for capitalization.

### 3.2 Shared Component Library
The system must provide the following reusable, highly customizable components matching the Figma designs:
- **AppButton**: Primary and secondary variants, supporting loading states (disabling interaction and showing an indicator).
- **AppTextField**: Input fields with consistent padding, borders, and support for validation errors and obscure text toggling (e.g., for passwords).
- **AppLoading**: A branded, centralized loading indicator.
- **AppErrorWidget**: A standardized error display with an icon, message, and an optional retry action.
- **AppAvatar**: A circular user profile image display that handles network images efficiently and provides a visually appealing fallback (initials on a colored background) when an image fails to load or is missing.

### 3.3 Form Validation & Utilities
- **Validators**: Provide centralized validation logic for emails, passwords (enforcing complexity rules), and required fields.
- **Formatting**: Provide utilities for consistent date and time formatting across the application.

## 4. Success Criteria

- **Measurable**: 100% of the UI components built in this phase perfectly match the provided Figma specifications in terms of padding, sizing, typography, and color.
- **Measurable**: The application compiles and runs without any static analysis errors or warnings related to the new components.
- **Qualitative**: Developers can build a sample form using only the provided shared components and `BuildContext` extensions without defining any local styles or colors.

## 5. Assumptions & Dependencies
- **Dependencies**: The project architecture strictly enforces that feature layers cannot directly import core design constants; they must use the `BuildContext` extensions.
- **Dependencies**: Relies on `flutter_screenutil` being properly initialized at the root of the app for responsive sizing.

## 6. Out of Scope
- Implementation of specific feature screens (e.g., the actual Login or Home pages) — this phase only builds the foundational blocks.
- Advanced or highly specific UI components not shared across multiple features.
