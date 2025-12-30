import 'package:flutter/material.dart';
import 'package:helping_hand/games/game1/situation5.dart';

class Situation4 extends StatefulWidget {
  const Situation4({super.key});

  @override
  State<Situation4> createState() => _Situation4State();
}

class _Situation4State extends State<Situation4> {
  String? selectedEmotion;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // 1. تغيير خلفية الشاشة الأساسية إلى الأبيض
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          // إضافة حواف داخلية للشاشة بالكامل
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // النص العلوي (تم تغيير لونه للأسود ليكون واضحاً على الخلفية البيضاء)


              // العنوان الرئيسي
              const Text(
                'علي يلعب لعبة و يخسر\n مرتين متتاليتين أمام صديقه',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.4,
                ),
              ),

              // الصورة
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  './assets/images/games-images/game1/image14.png',
                  height: screenHeight * 0.35,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: screenHeight * 0.35,
                    color: Colors.grey[100],
                    child: const Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
                ),
              ),

              // السؤال
              const Text(
                'بماذا يشعر علي؟',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              // أزرار الخيارات
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildEmotionOption('الحزن'),
                  _buildEmotionOption('الاحباط'),
                  _buildEmotionOption('التقبل'),
                ],
              ),

              // زر التالي
              SizedBox(
                width: double.infinity,
                height: 60,
                // child: ElevatedButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => Situation5(),
                //       ),
                //     );
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: const Color(0xFFA2E4B1), // الأخضر الفاتح
                //     foregroundColor: Colors.black,
                //     elevation: 2,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(30),
                //     ),
                //   ),
                //   child: const Text(
                //     'التالي',
                //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ودجت الخيارات (تم الحفاظ عليها كما في التصميم السابق)
  Widget _buildEmotionOption(String label) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFA8E3DA), // اللون التيفاني
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Situation5(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA2E4B1), // الأخضر الفاتح
          foregroundColor: Colors.black,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}