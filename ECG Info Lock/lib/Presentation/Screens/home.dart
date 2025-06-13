import 'package:ecg_info_lock/Core/Constants/app_colors.dart';
import 'package:ecg_info_lock/Core/Constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {

  final String userName;
  const Home({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                Container(
                  width: 15,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.button,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.r),
                      bottomRight: Radius.circular(15.r),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  'Welcome Home',
                  style: GoogleFonts.cormorant(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainText,
                  ),
                ),
              ],
            ),

            Expanded(
              child: Center(
                child: Text(
                  "It's good to see you back,\n$userName",
                  style: AppTextStyles.describtion,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
