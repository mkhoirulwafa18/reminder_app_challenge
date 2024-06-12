import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reminder_app_challenge/core/themes/app_colors.dart';

class AppTextStyles {
  static TextStyle body = GoogleFonts.poppins(fontSize: 12, color: AppColors.grey);
  static TextStyle bodyMd = GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14, color: AppColors.grey);
  static TextStyle title = GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16, color: AppColors.white);
}
