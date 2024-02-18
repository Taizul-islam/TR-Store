import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';




extension CustomText on String {
  dynamic apply(
      {required FontWeight fontWeight,
      required Color color,
      required double fontSize,
      int? maxLine,
      TextAlign? textAlign,
      TextOverflow? textOverflow,
      bool? softWrap}) {
    return Text(
      this,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize.sp,
        ),
      ),
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: textOverflow,
      softWrap: softWrap,
    );
  }
}

extension Toast on String {
  dynamic showToast(BuildContext context, Color bgColor, Color txtColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
          child: apply(
              fontWeight: FontWeight.w500, color: txtColor, fontSize: 12)),
      backgroundColor: bgColor,
    ));
  }
}



