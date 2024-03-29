import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_generator/config/config.dart';
import 'package:quote_generator/core/core.dart';
import 'package:quote_generator/features/features.dart';

class SettingsScreen extends ConsumerWidget {
  static SettingsScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const SettingsScreen();
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final themeState = ref.watch(themeProvider);
    final switchColor = colorScheme.primary;
    final themeLabelDisplay = themeState == ThemeMode.dark ? 'Dark' : 'Light';
    return Scaffold(
      body: BodyAndAppBarNestedScrollView(
        appBarTitle: 'Settings',
        centerTitle: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Dimensions.kVerticalSpaceLarge,
            ListTile(
              leading: Text(
                'Language',
                style: textTheme.bodyMedium,
              ),
              trailing: Padding(
                padding: Dimensions.kPaddingAllSmall,
                child: const LanguageSelector(),
              ),
            ),
            ListTile(
              leading: Text(
                themeLabelDisplay,
                style: textTheme.bodyMedium,
              ),
              trailing: Switch(
                value: themeState == ThemeMode.dark,
                activeColor: switchColor,
                inactiveTrackColor: switchColor,
                onChanged: (value) {
                  ref.read(themeProvider.notifier).changeTheme(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
