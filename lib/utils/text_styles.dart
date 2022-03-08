import 'package:my_books_to_read/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  TextStyles._();

  static const TextStyle appBarStyle = TextStyle(color: Colors.white);
  static const TextStyle primaryBodyStyle = TextStyle(fontSize: 16.0, color: AppColors.greyishBrown);
  static final TextStyle crochetAppStyle =
      GoogleFonts.yellowtail(fontSize: 40, color: AppColors.greyishBrown);
}
