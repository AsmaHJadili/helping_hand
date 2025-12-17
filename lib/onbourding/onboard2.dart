import 'package:flutter/material.dart';
import 'package:helping_hand/auth/signup/signup1.dart';
import 'package:helping_hand/homepage.dart';
import 'package:helping_hand/onbourding/onboard3.dart';

class OnBoard2 extends StatelessWidget {
  const OnBoard2({super.key});

  @override
  Widget build(BuildContext context) {
    // 💡 الحصول على أبعاد الشاشة لمرونة التصميم
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // 1. الصورة الخلفية
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'images/hands.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // 2. طبقة التغميق (Dark Overlay) لزيادة وضوح النص الأبيض
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5), // تغميق 50%
          ),

          // 3. العنوان النصي
          Positioned(
            top: screenHeight * 0.35, // 👈 تحديد الموقع كنسبة من الارتفاع (35%)
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                "العاب يلعبها طفلك\nتساعدنا على تحليل أولي\nلصحته النفسية",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white, // تم تغيير اللون للأبيض ليتناسب مع الخلفية الداكنة
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
            ),
          ),

          // 4. مؤشرات الصفحات (النقاط)
          Positioned(
            bottom: screenHeight * 0.40, // 👈 تحديد الموقع كنسبة من الارتفاع
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDot(color: Color(0xFF8A8E8F)), // النقطة الحالية
                const SizedBox(width: 8),
                _buildDot(color: Colors.white), // النقطة غير الحالية
                const SizedBox(width: 8),
                _buildDot(color: const Color(0xFF8A8E8F)), // النقطة غير الحالية
              ],
            ),
          ),

          // 5. الأزرار (Buttons)
          Positioned(
            bottom: screenHeight * 0.15, // 👈 تحديد الموقع من الأسفل
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  // زر التالي (ElevatedButton)
                  SizedBox(
                    width: double.infinity, // لجعل الزر يملأ العرض
                    child: ElevatedButton(
                      onPressed: () {
                        // الانتقال إلى الشاشة التالية
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const OnBoard3()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        // تطبيق اللون المخصص مع شفافية 90%
                        backgroundColor: const Color.fromARGB(255, 138, 96, 48).withOpacity(0.10), 
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        'التالي',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // زر تخطي (TextButton)
                  TextButton(
                    onPressed: () {
                      // الانتقال إلى الرئيسية مع pushReplacement لمنع العودة
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Signup1()),
                      );
                    },
                    child: const Text(
                      'تخطي',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 💡 دالة مساعدة لإنشاء مؤشر النقطة
  Widget _buildDot({required Color color}) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(400)),
      ),
    );
  }
}