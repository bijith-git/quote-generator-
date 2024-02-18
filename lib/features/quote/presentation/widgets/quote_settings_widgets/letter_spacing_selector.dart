import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_generator/config/config.dart';
import 'package:quote_generator/features/quote/quote.dart';

class LetterSpacingSelector extends ConsumerStatefulWidget {
  const LetterSpacingSelector({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LetterSpacingSelectorState();
}

class _LetterSpacingSelectorState extends ConsumerState<LetterSpacingSelector> {
  int _isSelected = 0;

  double _selectedletterSpacingSize(int index) {
    final letterSpacingSize = [
      Dimensions.quoteTextLetterSpacingNone,
      Dimensions.quoteTextLetterSpacingSmall,
      Dimensions.quoteTextLetterSpacingMedium,
      Dimensions.quoteTextLetterSpacingLarge,
    ];
    return letterSpacingSize[index];
  }

  @override
  Widget build(BuildContext context) {
    final spaces = [
      Text(
        'None',
      ),
      Text(
        'Small',
        style: TextStyle(
          letterSpacing: Dimensions.quoteTextLetterSpacingSmall,
        ),
      ),
      Text(
        'Medium',
        style: TextStyle(
          letterSpacing: Dimensions.quoteTextLetterSpacingMedium,
        ),
      ),
      Text(
        'Large',
        style: TextStyle(
          letterSpacing: Dimensions.quoteTextLetterSpacingLarge,
        ),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingTitle(title: 'Letter spacing'),
        SizedBox(
          height: Dimensions.kQuoteTextSettingHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              final space = spaces[index];
              return TextSettingItemContainer(
                onTap: () {
                  ref
                      .read(textSettingsProvider.notifier)
                      .setLetterSpacing(_selectedletterSpacingSize(index));
                  setState(() {
                    _isSelected = index;
                  });
                },
                isSelected: _isSelected == index,
                child: space,
              );
            },
            separatorBuilder: (ctx, index) {
              return Dimensions.kHorizontalSpaceMedium;
            },
            itemCount: spaces.length,
          ),
        ),
      ],
    );
  }
}
