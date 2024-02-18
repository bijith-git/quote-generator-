import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_generator/config/config.dart';
import 'package:flutter/material.dart';
import 'package:quote_generator/features/features.dart';

class AppAlerts {
  const AppAlerts._();

  static displaySnackbar(BuildContext context, String message, bool isSucess) {
    final colorScheme = context.colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textTheme.bodyMedium,
        ),
        backgroundColor:
            isSucess ? colorScheme.onSecondary : colorScheme.onError,
      ),
    );
  }

  static Future<void> showAlertDeleteDialog({
    required BuildContext context,
    required WidgetRef ref,
    required int quoteId,
  }) async {
    Widget cancelButton = TextButton(
      child: Text("cancel".toUpperCase()),
      onPressed: () => context.pop(),
    );
    Widget deleteButton = TextButton(
      onPressed: () async {
        context.pop();
        await ref.read(deleteQuoteProvider.notifier).deleteQuote(quoteId).then(
          (value) {
            AppAlerts.displaySnackbar(
              context,
              "Quote deleted successfully",
              true,
            );
            context.pop();
          },
        );
      },
      child: Text("delete".toUpperCase()),
    );

    AlertDialog alert = AlertDialog(
      title: Text('Delete this quote?'),
      content: Text('Are you sure you want to delete this quote?'),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
