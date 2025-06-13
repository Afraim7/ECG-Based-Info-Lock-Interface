import 'package:another_flushbar/flushbar.dart';
import 'package:ecg_info_lock/Core/Constants/app_colors.dart';
import 'package:ecg_info_lock/Core/Constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class MessageBar {

  final String barType;
  final String message;
  
  MessageBar(this.barType, {required this.message});


  void show(BuildContext context) {
    Flushbar(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(20),
      backgroundColor: (barType.toLowerCase() == 'error')? AppColors.error : AppColors.success,
      flushbarPosition: (barType.toLowerCase() == 'error')? FlushbarPosition.BOTTOM : FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      barBlur: 10,
      duration: Duration(seconds: 3),
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Icon(
              (barType.toLowerCase() == 'error')? Icons.error_outline : Icons.check_circle_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (barType.toLowerCase() == 'error')? 'Error' : 'Success',
                  style: AppTextStyles.messageTitle
                ),
                Text(
                  message,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.messageDescription
                ),
              ],
            ),
          ),
        ],
      ),
    ).show(context);
  }
}
