import 'package:ecg_info_lock/Core/Constants/app_colors.dart';
import 'package:ecg_info_lock/Core/Constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  final bool biometricUploaded;
  final List<double> signalSamples;
  final List<double> timeVector;

  const Chart({
    super.key,
    required this.biometricUploaded,
    required this.signalSamples,
    required this.timeVector,
  });

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {

    final double chartHeight = MediaQuery.of(context).size.height * 0.35;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      width: double.infinity,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: widget.biometricUploaded
            ? AppColors.button.withOpacity(0.5)
            : AppColors.button.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.background.withOpacity(0.15),
                ),
                child: const Icon(
                  Icons.bar_chart_rounded,
                  color: AppColors.background,
                  size: 25,
                ),
              ),
              Text(
                '  Your ECG biometric',
                style: GoogleFonts.workSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.background,
                ),
              ),
            ],
          ),
          if (widget.biometricUploaded && widget.signalSamples.isNotEmpty && widget.timeVector.isNotEmpty) ...[
            SizedBox(height: 20.h),
            SizedBox(
              height: chartHeight - 90.h,
              child: SfCartesianChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                  enablePinching: true,
                  enableDoubleTapZooming: true,
                  enableMouseWheelZooming: true,
                  enableSelectionZooming: true,
                  zoomMode: ZoomMode.x,
                ),
                primaryXAxis: NumericAxis(
                  title: AxisTitle(
                    text: 'Time (s)',
                    textStyle: AppTextStyles.describtion.copyWith(fontSize: 10.sp)
                  ),
                  axisLine: const AxisLine(width: 2),
                  majorGridLines: const MajorGridLines(width: 0.5),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  labelStyle: AppTextStyles.describtion.copyWith(fontSize: 10.sp),
                  minimum: widget.timeVector.first,
                  maximum: widget.timeVector.last,
                  enableAutoIntervalOnZooming: true,
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(
                    text: 'Voltage (V)',
                    textStyle: AppTextStyles.describtion.copyWith(fontSize: 10.sp)
                  ),
                  axisLine: const AxisLine(width: 2),
                  majorGridLines: const MajorGridLines(width: 0.5),
                  minimum: 0,
                  maximum: 0.5,
                  labelStyle: AppTextStyles.describtion.copyWith(fontSize: 10.sp),
                ),
                series: <LineSeries<double, double>>[
                  LineSeries<double, double>(
                    name: 'ECG Data',
                    dataSource: List.generate(widget.signalSamples.length, (i) => widget.timeVector[i]),
                    xValueMapper: (time, index) => time,
                    yValueMapper: (time, index) => -widget.signalSamples[index],
                    color: Colors.red.shade900,
                    width: 2,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
