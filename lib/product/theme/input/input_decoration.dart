import 'package:flutter/material.dart';

import '../colors/color_manager.dart';
import '../text/text_theme.dart';

class CustomInputDecoration extends InputDecorationTheme {
  CustomInputDecoration(ITextTheme textTheme, IColors colors)
      : super(
          hintStyle: textTheme.titleMedium,
          fillColor: colors.inputFilledColor,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24), borderSide: BorderSide(color: colors.colors.warmPink, width: 2)),
        );
}
