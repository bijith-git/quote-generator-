import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quote_generator/config/config.dart';
import 'package:quote_generator/features/quote/quote.dart';
import 'package:quote_generator/core/core.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({super.key, required this.quote});

  final Quote quote;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayFavoriteIcon = quote.isFavorite == 1
        ? FontAwesomeIcons.solidHeart
        : FontAwesomeIcons.heart;

    return QuoteCardButton(
      child: FaIcon(
        displayFavoriteIcon,
        size: Dimensions.iconSizeSmallest,
        color: context.colorScheme.primary,
      ),
      onPressed: () async {
        await ref
            .read(updateQuoteProvider.notifier)
            .updateFavorite(quote)
            .then((value) async {
          await AppAlerts.displaySnackbar(
            context,
            _addOrRemovefavMessage(context),
            true,
          );
        });
      },
    );
  }

  String _addOrRemovefavMessage(BuildContext context) {
    return quote.isFavorite == 1
        ? 'Quote removed from favorites successfully'
        : 'Quote added to favorites successfully';
  }
}
