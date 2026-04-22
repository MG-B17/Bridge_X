# Phase 1: Quickstart

## How to use colors and typography

1. Ensure your widget has access to a `BuildContext`.
2. Do NOT import `AppColors` or `AppTextStyles` directly.
3. Access colors via `context.colors.primary`, `context.colors.surface`, etc.
4. Access typography via `context.headlineMedium`, `context.bodyLarge`, etc.

## How to use shared widgets

1. **Button**: `AppButton(text: 'Submit', onPressed: () {})`
2. **TextField**: `AppTextField(hintText: 'Enter Email', controller: emailController)`
3. **Avatar**: `AppAvatar(imageUrl: 'https...', name: 'John Doe')`
4. **Loading**: `const AppLoading()`
5. **Error**: `AppErrorWidget(message: 'Failed to load', onRetry: () {})`
