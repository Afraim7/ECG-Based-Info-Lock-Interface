import 'package:ecg_info_lock/Core/Constants/app_colors.dart';
import 'package:ecg_info_lock/Core/Constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnlockButton extends StatelessWidget {

  final VoidCallback onPressed;
  const UnlockButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.button,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        child: Text(
          'Unlock',
          style: AppTextStyles.button
        ),
      ),
    );
  }
}
