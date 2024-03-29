import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quote_generator/config/config.dart';
import 'package:quote_generator/core/utils/utils.dart';
import 'package:quote_generator/features/discovery/discovery.dart';
import 'package:quote_generator/features/quote/quote.dart';

class QuoteDetailBody extends ConsumerWidget {
  const QuoteDetailBody({
    super.key,
    required this.quote,
  });

  final Quote quote;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor = context.colorScheme.onSurface;
    final displayFavoriteIcon = quote.isFavorite == 1
        ? FontAwesomeIcons.solidHeart
        : FontAwesomeIcons.heart;

    return Container(
      margin: Dimensions.kPaddingAllLarge,
      padding: Dimensions.kPaddingAllLarge,
      decoration: BoxDecoration(
        color: Color(quote.backgroundColor),
        borderRadius: Dimensions.kBorderRadiusAllLarge,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.quoteLeft,
            size: Dimensions.iconSizeLarge,
            color: textColor,
          ),
          Dimensions.kVerticalSpaceSmall,
          Text(
            quote.quoteText,
            textAlign: AppHelpers.textAlignList[quote.textAlign],
            style: TextStyle(
              color: textColor,
              fontSize: quote.fontSize,
              fontWeight: AppHelpers.fontWeightList[quote.fontWeight],
              wordSpacing: quote.wordSpacing,
              letterSpacing: quote.letterSpacing,
            ),
          ),
          Dimensions.kVerticalSpaceSmall,
          Text(
            '- ${quote.author}',
            textAlign: AppHelpers.textAlignList[quote.textAlign],
            style: context.textTheme.bodyMedium?.copyWith(
              color: textColor,
            ),
          ),
          Dimensions.kVerticalSpaceLarge,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  displayFavoriteIcon,
                  size: Dimensions.iconSizeLarge,
                ),
                color: textColor,
                onPressed: () async {
                  await ref
                      .read(updateQuoteProvider.notifier)
                      .updateFavorite(quote)
                      .then((value) {
                    _showSnackBar(context);
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.shareNodes,
                  size: Dimensions.iconSizeLarge,
                ),
                color: textColor,
                onPressed: () async {
                  final quoteText = quote.quoteText;
                  final quoteAuthor = quote.author;
                  await AppHelpers.shareQuote(
                    quoteText,
                    quoteAuthor,
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.rss,
                  size: Dimensions.iconSizeLarge,
                ),
                color: textColor,
                onPressed: () async {
                  ref.read(postQuoteProvider(quote));
                  await AppAlerts.displaySnackbar(
                    context,
                    'Quote posted successfully!',
                    false,
                  );
                },
              ),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.trashCan,
                  size: Dimensions.iconSizeLarge,
                ),
                color: textColor,
                onPressed: () async {
                  final quoteId = AppHelpers.stringToInt('${quote.id}');
                  await AppAlerts.showAlertDeleteDialog(
                    context: context,
                    ref: ref,
                    quoteId: quoteId,
                  );
                },
              ),
            ],
          ),
        ].animate().slide().then().shake(),
      ),
    );
  }

  void _showSnackBar(BuildContext context) {
    final String msg = quote.isFavorite == 1
        ? 'Quote removed from favorites successfully'
        : 'Quote added to favorites successfully';

    AppAlerts.displaySnackbar(context, msg, true);
  }
}
