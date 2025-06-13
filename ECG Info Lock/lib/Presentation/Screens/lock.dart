import 'package:ecg_info_lock/Core/Constants/app_colors.dart';
import 'package:ecg_info_lock/Core/Constants/app_messages.dart';
import 'package:ecg_info_lock/Core/Constants/app_text_styles.dart';
import 'package:ecg_info_lock/Data/Models/biometri_data.dart';
import 'package:ecg_info_lock/Logic/Cubit/info_unlock_cubit.dart';
import 'package:ecg_info_lock/Logic/Cubit/info_unlock_states.dart';
import 'package:ecg_info_lock/Presentation/Screens/home.dart';
import 'package:ecg_info_lock/Presentation/Widgets/chart.dart';
import 'package:ecg_info_lock/Shared/loading_dialog.dart';
import 'package:ecg_info_lock/Shared/message_bar.dart';
import 'package:ecg_info_lock/Presentation/Widgets/unlock_button.dart';
import 'package:ecg_info_lock/Presentation/Widgets/upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class Lock extends StatefulWidget {
  const Lock({super.key});  

  @override
  State<Lock> createState() => _LockState();
}

class _LockState extends State<Lock> {

  BiometriData? userBiometric;
  bool signalPicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80.h),
          
                Text(
                  'Welcome',
                  style: GoogleFonts.cormorant(
                    color: AppColors.mainText,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 7),
                  child: Text(
                    AppMessages.uploadDescribtion,
                    style: AppTextStyles.describtion,
                    textAlign: TextAlign.center,
                  ),
                ),
                    
                SizedBox(height: 40.h),
                
                UploadButton(
                  uploadBiometric: () {
                    BlocProvider.of<InfoUnlockCubit>(context).upload();
                  },
                ),
                    
                SizedBox(height: 30.h),
                    
                BlocConsumer<InfoUnlockCubit, InfoUnlockStates>(
                  listener: (context, state) {
          
                    if(state is Loading) {
                      if (ModalRoute.of(context)?.isCurrent ?? false) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => LoadingDialog(),
                        );
                      }
                    }
          
                    else if (state is Uploaded) {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      setState(() {
                        signalPicked = state.signalPicked;
                      });
          
                      if(signalPicked) {
                        MessageBar('success', message: AppMessages.uploadedSuccess).show(context);
                        userBiometric = state.userBiometric;
                      }
                    }
          
                    else if (state is Error) {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      
                      MessageBar('error', message: state.error).show(context);
                    }
          
                    else if(state is Authenticated) {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(userName: userBiometric?.patientName ?? '')
                        ),
                      );
                    }
          
                    else if (state is Unauthenticated) {
                      MessageBar('error', message: state.error).show(context);
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Chart(
                        signalSamples: userBiometric?.signalSamples ?? [],
                        timeVector: userBiometric?.timeVector ?? [],
                        biometricUploaded: signalPicked,
                      ),
                    );
                  },
                ),
                                        
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                  child: UnlockButton(
                    onPressed: () {
                      BlocProvider.of<InfoUnlockCubit>(context).authenticate(
                        identifyingResult: userBiometric?.result ?? ''
                      );
                    },
                  ),
                ),
                
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
