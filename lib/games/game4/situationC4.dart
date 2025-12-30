import 'package:flutter/material.dart';
import 'package:helping_hand/games/end4start5.dart';

class SituationC4 extends StatefulWidget {
  const SituationC4({super.key});

  @override
  State<SituationC4> createState() => _SituationC4State();
}

class _SituationC4State extends State<SituationC4> {
  String? selectedEmotion;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            // تم استخدام spaceBetween لضمان توزيع العناصر على كامل الشاشة
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 1. العنوان (محدث بناءً على الصورة eeee.PNG)
              const Text(
                'أنت تشارك في فعالية \n ولم يصفق لك أحد ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.4,
                ),
              ),

              // 2. الصورة
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  './assets/images/games-images/game1/image12.png',
                  height: screenHeight * 0.30,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: screenHeight * 0.30,
                    color: Colors.grey[100],
                    child: const Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
                ),
              ),

              // 3. سؤال السلوك
              const Text(
                'ماذا ستفعل؟',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              // 4. أزرار الخيارات (مرتبة فوق بعضها عمودياً)
              Column(
                children: [
                  _buildEmotionOption('أشعر اني غير محبوب'),
                  const SizedBox(height: 15), // مسافة بين الأزرار
                  _buildEmotionOption('لا أهتم'),
                  const SizedBox(height: 15),
                  _buildEmotionOption('أصفق لوحدي وأضحك'),
                ],
              ),

              // 5. زر التالي
              SizedBox(
                width: double.infinity,
                height: 60,
                // child: ElevatedButton(
                //   onPressed: () {
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(builder: (context) => const Situation5()),
                //     // );
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: const Color(0xFFA2E4B1),
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

  // ودجت الخيارات معدلة لتأخذ العرض الكامل
  Widget _buildEmotionOption(String label) {
    return Container(
      width: double.infinity, // لجعل الخيارات بنفس العرض
      // padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFA8E3DA),
        borderRadius: BorderRadius.circular(25),
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
            MaterialPageRoute(builder: (context) => End4Start5()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA2E4B1),
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