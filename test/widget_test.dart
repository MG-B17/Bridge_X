import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bridgex/app.dart';
import 'package:bridgex/core/theme/app_them.dart';
import 'package:bridgex/core/utils/extensions.dart';

void main() {
  testWidgets('Theme resolves without null errors', (WidgetTester tester) async {
    await tester.pumpWidget(ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp(
        theme: AppTheme.light,
        home: Builder(builder: (ctx) {
          // These will throw if they can't find the extension or the style
          expect(ctx.colors.primary, isNotNull);
          expect(ctx.bodyMedium, isNotNull);
          return const SizedBox();
        }),
      ),
    ));
  });

  testWidgets('App renders smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that it renders (it currently shows a Placeholder)
    expect(find.byType(Placeholder), findsOneWidget);
  });
}
