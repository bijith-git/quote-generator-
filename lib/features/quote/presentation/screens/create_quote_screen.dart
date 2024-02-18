import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_generator/core/utils/utils.dart';
import 'package:quote_generator/features/quote/quote.dart';
import 'package:quote_generator/config/config.dart';
import 'package:quote_generator/features/features.dart';

class CreateQuoteScreen extends ConsumerWidget {
  static CreateQuoteScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const CreateQuoteScreen();
  const CreateQuoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: Dimensions.kPaddingHorizontalSmall,
              child: TextButton(
                onPressed: () async {
                  await _saveQuoteInDB(ref, context);
                },
                child: Text(
                  'Done'.toUpperCase(),
                  style: textTheme.titleLarge?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: Dimensions.kPaddingHorizontalLarge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Create Your Quote',
                style: textTheme.displayMedium,
              ),
              const QuoteTextField(),
              const DisplayTextSettings(),
              const BackgroundColorPicker(),
              Dimensions.kVerticalSpaceLargest
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveQuoteInDB(WidgetRef ref, BuildContext ctx) async {
    final quoteText = ref.watch(textSettingsProvider).quoteText;
    FocusManager.instance.primaryFocus?.unfocus();
    if (quoteText.trim().isNotEmpty) {
      await ref.read(addQuoteProvider.notifier).addQuote().then(
        (value) {
          ctx.pop();
          AppAlerts.displaySnackbar(
            ctx,
            'Quote created successfully!',
            true,
          );
        },
      );
    } else {
      AppAlerts.displaySnackbar(
        ctx,
        '${'Quote must not be empty!'}'
        '\n${'Please enter a quote to save this.'}',
        false,
      );
    }
  }
}
