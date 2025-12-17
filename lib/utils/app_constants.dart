import 'package:flutter/material.dart';

// الألوان الرئيسية
const Color primaryTeal = Colors.white; // التركوازي الخلفي
const Color lightTeal = Color.fromARGB(255, 223, 234, 255);                 // لون حقول الإدخال والأزرار الخفيفة
const Color darkButtonColor = Color.fromARGB(255, 168, 198, 255);           // لون زر تسجيل الدخول/التالي
const Color whiteBackground = Colors.white;

// الخط (نستخدم Cairo لأنه قريب من التصميم ويدعم اللغة العربية بقوة)
// import 'package:google_fonts/google_fonts.dart';
// final TextStyle appTextStyle = GoogleFonts.cairo(
//   fontWeight: FontWeight.bold,
//   color: darkButtonColor,
// );