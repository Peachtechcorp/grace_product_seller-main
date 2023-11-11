import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

double eight = 0.0213;
double ten = 0.0267;
double twelve = 0.032;
double fourteen = 0.037;
double thirty = 0.08;
double fifteen = 0.04;
double sixteen = 0.042666;
double eighteen = 0.048;
double twenty = 0.053;
double twentysix = 0.0693;
double twentyeight = 0.07466;
double twentyfour = 0.064;
double fourty = 0.10667;
double pagePadding = 0.04;
double borderRadius = 0.1;
Color purple = const Color(0xFFB471FF);
Color yellow = const Color(0xFFFFCD28);
Color blue = const Color(0xFF304FFD);
Color orange = const Color(0xFFFF965D);
Color page = const Color(0xFFf2f2f2);
Color buttonColor = const Color(0xFF6CB63B);
Color hintColor = const Color(0xFFA0A4A8);
Color containerHeaderColor = const Color(0xFFC8C8C8);
Color warningColor = const Color(0xFFFEFFDB);
Color successColor = const Color(0xFFEDFFED);
Color textWarningColor = const Color(0xFFB4AD10);
Color textSuccessColor = const Color(0xFF24AD01);
Color backgroundColor = const Color(0xFFC7C7C7);

InputDecoration defaultDecoration({
  required Size media,
  required hintText,
  Icon? prefixIcon,
  Icon? suffixIcon,
}) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(
        horizontal: media.width * 0.02, vertical: media.width * 0.05),
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(media.width * 0.07),
    ),
    hintText: hintText,
    hintStyle: TextStyle(
      fontSize: media.width * twelve,
      color: hintColor,
    ),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
  );
}

TextStyle tableTextStyle(Size media) {
  return TextStyle(
    fontSize: media.width * twelve,
  );
}

String formatDate(DateTime date, {bool showTime = false}) {
  DateFormat format;

  if (showTime) {
    format = DateFormat('d MMM y, H:mm');
  } else {
    format = DateFormat('d MMM y');
  }
  return format.format(date);
}

String formatTime(DateTime date, {bool is24 = true}) {
  DateFormat format;

  if (is24) {
    format = DateFormat('H:mm');
  } else {
    format = DateFormat.jm();
  }
  return format.format(date);
}

String formatMoney(dynamic amount) {
  NumberFormat format = NumberFormat();
  return format.format(amount);
}

TextStyle labelStyle(Size media) {
  return TextStyle(
    fontSize: media.width * ten,
    fontWeight: FontWeight.w500,
  );
}
