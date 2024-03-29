import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_generator/features/quote/quote.dart';
import 'package:quote_generator/config/config.dart';

class WordSpacingSelector extends ConsumerStatefulWidget {
  const WordSpacingSelector({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WordSpacingSelectorState();
}

class _WordSpacingSelectorState extends ConsumerState<WordSpacingSelector> {
  int _isSelected = 0;

  double _selectedWordSpacingSize(int index) {
    final wordSpacingSize = [
      Dimensions.quoteTextWordSpacingNone,
      Dimensions.quoteTextWordSpacingSmall,
      Dimensions.quoteTextWordSpacingMedium,
      Dimensions.quoteTextWordSpacingLarge,
    ];
    return wordSpacingSize[index];
  }

  @override
  Widget build(BuildContext context) {
    final wordSpaces = [
      'None',
      'Small',
      'Medium',
      'Large',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingTitle(title: 'Word spacing'),
        SizedBox(
          height: Dimensions.kQuoteTextSettingHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              final space = wordSpaces[index];
              return TextSettingItemContainer(
                onTap: () {
                  ref
                      .read(textSettingsProvider.notifier)
                      .setWordSpacing(_selectedWordSpacingSize(index));
                  setState(() {
                    _isSelected = index;
                  });
                },
                isSelected: _isSelected == index,
                child: Text(space),
              );
            },
            separatorBuilder: (ctx, index) {
              return Dimensions.kHorizontalSpaceMedium;
            },
            itemCount: wordSpaces.length,
          ),
        ),
      ],
    );
  }
}
