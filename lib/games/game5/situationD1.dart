import 'dart:async';
import 'package:flutter/material.dart';

class SituationD1 extends StatefulWidget {
  @override
  _SituationD1State createState() => _SituationD1State();
}

class _SituationD1State extends State<SituationD1> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // 1. إعداد المؤقت للانتقال التلقائي بعد 5 ثوانٍ
    _timer = Timer(Duration(seconds: 5), _navigateToNextScreen);
  }

  void _navigateToNextScreen() {
    if (mounted) {
      _timer?.cancel(); // إلغاء المؤقت لتجنب تكرار الانتقال
      // استبدل NextScreen() بالصفحة التالية لديك
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => NextScreen()),
      // );
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // تنظيف الذاكرة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // النص العلوي
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "إذا رأيت أن تصرف الفتى إيجابي\nانقر على الصورة",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            
            // 2. الصورة مع خاصية النقر
            GestureDetector(
              onTap: _navigateToNextScreen, // الانتقال عند النقر
              child: ClipOval(
                child: Image.asset(
                  './assets/images/games-images/game5/image1.jpg', // مسار الصورة الخاص بك
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// صفحة تجريبية للانتقال إليها
class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("الصفحة التالية")));
  }
}