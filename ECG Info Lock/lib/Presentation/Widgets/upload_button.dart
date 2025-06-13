import 'package:ecg_info_lock/Core/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadButton extends StatefulWidget {

  final VoidCallback uploadBiometric;
  const UploadButton({super.key, required this.uploadBiometric});

  @override
  State<UploadButton> createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.uploadBiometric,
      onHover: (value) {
        setState(() {
          isHovering = value;
        });
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 110.w,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.button.withOpacity(0.1),
          border: Border.all(
            color: AppColors.button,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            'Upload',
            style: GoogleFonts.workSans(
              color: AppColors.mainText,
              fontSize: (isHovering)? 16.sp : 15.sp,
              fontWeight: FontWeight.w400,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
