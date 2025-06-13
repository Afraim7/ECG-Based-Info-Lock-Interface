import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {

  static TextStyle describtion = GoogleFonts.workSans(
    color: AppColors.subText,
    fontSize: 13.sp,
    fontWeight: FontWeight.w400
  );

  static TextStyle button = GoogleFonts.workSans(
    color: AppColors.mainText,
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
  );

  static TextStyle messageTitle = GoogleFonts.workSans(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    color: AppColors.mainText,
  );

  static TextStyle messageDescription = GoogleFonts.cormorant(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white70,
  );
  
}
