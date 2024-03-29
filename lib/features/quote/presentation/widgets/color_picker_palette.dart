import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:quote_generator/config/config.dart';

class ColorPickerPalette extends StatelessWidget {
  const ColorPickerPalette({
    super.key,
    required this.selectedColor,
    required this.onColorChanged,
  });

  final Color selectedColor;
  final Function(Color color) onColorChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 1,
        child: ColorPicker(
          color: selectedColor,
          onColorChanged: (Color color) => onColorChanged(color),
          width: Dimensions.colorPaletteWidth,
          height: Dimensions.colorPaletteHight,
          borderRadius: Dimensions.colorPaleteBorder,
          heading: Text(
            'Select background color',
            style: textTheme.headlineSmall,
          ),
          subheading: Text(
            'Select color shade',
            style: textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
