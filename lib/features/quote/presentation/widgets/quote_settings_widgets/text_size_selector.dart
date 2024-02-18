import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_generator/features/quote/quote.dart';
import 'package:quote_generator/config/config.dart';

class TextSizeSelector extends ConsumerStatefulWidget {
  const TextSizeSelector({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TextSizeSelectorState();
}

class _TextSizeSelectorState extends ConsumerState<TextSizeSelector> {
  int _isSelected = 0;

  double _selectedTextSize(int index) {
    final textSizeList = [
      Dimensions.quoteTextFontSizeSmall,
      Dimensions.quoteTextFontSizeMedium,
      Dimensions.quoteTextFontSizeLarge,
    ];
    return textSizeList[index];
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final fontSizes = [
      Text(
        'Small',
        style: textTheme.bodySmall,
      ),
      Text(
        'Medium',
        style: textTheme.bodyMedium,
      ),
      Text(
        'Large',
        style: textTheme.bodyLarge,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingTitle(title: 'Font size'),
        SizedBox(
          height: Dimensions.kQuoteTextSettingHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              final fontSize = fontSizes[index];
              return TextSettingItemContainer(
                onTap: () {
                  ref
                      .read(textSettingsProvider.notifier)
                      .setFontSize(_selectedTextSize(index));
                  setState(() {
                    _isSelected = index;
                  });
                },
                isSelected: _isSelected == index,
                child: fontSize,
              );
            },
            separatorBuilder: (ctx, index) {
              return Dimensions.kHorizontalSpaceMedium;
            },
            itemCount: fontSizes.length,
          ),
        ),
      ],
    );
  }
}
