import 'package:flutter/material.dart';
import 'package:helping_hand/homepage.dart';
import 'package:helping_hand/onbourding/onboard1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // نستخدم addPostFrameCallback لضمان أننا خارج مرحلة البناء
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () async{
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        bool? isSign = sharedPreferences.getBool("isSignup");
        if(isSign == true){
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );}else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnBoard1()),
        );
        }
        
      });
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        // 1. الصورة (يجب أن تكون كاملة الوضوح هنا)
        Image.asset(
          'images/hands.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        
        // 2. طبقة تغميق (لتوضيح النص)
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.4), // 👈 تغميق متوسط
        ),

        // 3. النص في المنتصف
        Center(
          child: Text(
            "HELPING HAND",
            style: const TextStyle( // 👈 استخدم const
              color: Colors.black, // 👈 تغيير لون النص إلى الأبيض
              fontWeight: FontWeight.w900,
              fontSize: 24,
              letterSpacing: 4
            ),
          ),
        ),
      ],
    ),
  );
}
}
