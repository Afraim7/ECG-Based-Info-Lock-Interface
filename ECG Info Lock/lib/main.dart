import 'package:device_preview/device_preview.dart';
import 'package:ecg_info_lock/Logic/Cubit/info_unlock_cubit.dart';
import 'package:ecg_info_lock/Presentation/Screens/lock.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          useInheritedMediaQuery: true,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return BlocProvider(
              create: (_) => InfoUnlockCubit(),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                useInheritedMediaQuery: true,
                builder: DevicePreview.appBuilder,
                locale: DevicePreview.locale(context),
                home: Lock(),
              ),
            );
          },
        );
      },
    );
  }
}
