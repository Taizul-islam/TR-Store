import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:task_app/core/extension/extensions.dart';

import '../core/network/error_handler.dart';
import '../core/utils/height_util.dart';
import '../core/utils/lottie_util.dart';
import '../core/utils/width_util.dart';
import 'button_widget.dart';

class FailureWidget extends StatelessWidget {
  final String error;
  final VoidCallback? onExitTap;
  final VoidCallback? onRetryTap;
  final bool isExitButtonShow;
  final String? cancelBtnText;

  const FailureWidget(
      {super.key,
      required this.error,
      this.onExitTap,
      this.onRetryTap,
      required this.isExitButtonShow,
      this.cancelBtnText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(50.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(getLottie(error), height: 250.h, width: 250.h),
          height(10.h),
          getErrorMessageFromCode(error).toString().apply(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 10.sp,
              textAlign: TextAlign.center),
          height(50.h),
          Row(
            children: [
              Visibility(
                visible: isExitButtonShow,
                child: Expanded(
                  child: ButtonWidget(
                    onTap: onExitTap,
                    bgColor: Colors.white.withOpacity(0.1),
                    radius: 10,
                    btnText: cancelBtnText ?? "",
                    btnSize: Size(ScreenUtil().screenWidth, 40.h),
                    fontSize: 12.sp,
                    loading: false,
                    txtColor: Colors.white,
                  ),
                ),
              ),
              Visibility(visible: isExitButtonShow, child: width(20.w)),
              Expanded(
                child: ButtonWidget(
                  onTap: onRetryTap,
                  bgColor: Colors.blueAccent,
                  radius: 10,
                  btnText: "Retry",
                  btnSize: Size(ScreenUtil().screenWidth, 40.h),
                  fontSize: 12.sp,
                  loading: false,
                  txtColor: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
