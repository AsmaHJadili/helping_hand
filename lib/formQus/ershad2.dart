import 'package:flutter/material.dart';
import 'package:helping_hand/formQus/sdq1.dart';
import 'package:helping_hand/homepage.dart';

// تعريف الألوان المشتركة
const Color primaryTeal = Colors.white; // لون الشكل المنحني في الأعلى (الأبيض)
const Color darkBackground = Color.fromRGBO(70, 236, 213, 0.8); // لون خلفية التطبيق (التركوازي الغامق)
const Color buttonColor = Color(0xFF2A2D34); // لون زر "ابدأ" (الأسود الداكن)
const Color stepColor = Color(0xFF2A2D34); // لون نصوص الخطوات (الأسود الداكن)

class Ershad2 extends StatefulWidget {
  const Ershad2({super.key});

  @override
  State<Ershad2> createState() => _Ershad2();
}

class _Ershad2 extends State<Ershad2> {

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: darkBackground, // لون الخلفية التركوازي الغامق
        body: Column(
          children: <Widget>[
            // 1. الجزء العلوي بالشكل المنحني (Header)
            _buildCurvedHeader(context),

            // 2. محتوى الخطوات التوجيهية
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 30),
                    
                    // العنوان التوجيهي الثانوي
                    const Text(
                      'تأكد من اتباع الخطوات الاتية',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // قائمة الخطوات (الميزات التوجيهية)
                    _buildStepText('حضر طفلك ودعه يلعب بنفسه'),
                    _buildStepText('سيلعب خمس العاب متتالية'),
                    _buildStepText('ستسغرق نصف ساعة من الوقت'),

                    const Spacer(), // لدفع الزر إلى الأسفل

                    // زر "ابدأ"
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // منطق الانتقال لبدء الاستبيان SDQ
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('جارٍ بدء اللعب ...')),
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Homepage()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor, // لون الزر الأسود
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'ابدأ',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة بناء نص الخطوة
  Widget _buildStepText(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white, width: 2), // خط فاصل أبيض
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white, // لون النص الأسود الداكن
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  // بناء الجزء العلوي بالشكل المنحني
  Widget _buildCurvedHeader(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ClipPath(
      clipper: SDQClipper(), // استخدام Clipper الخاص بهذه الصفحة
      child: Container(
        height: screenHeight * 0.40, // ارتفاع مناسب للعنوان
        width: screenWidth,
        color: primaryTeal, // لون الخلفية الأبيض
        child: Stack(
          children: [
            // أيقونة الرجوع
            Positioned(
              top: 40,
              left: 20, // وضعه على اليمين في تصميم RTL
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 28),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            // النص الرئيسي
            Positioned(
              top: 100,
              right: screenWidth * 0.1,
              left: screenWidth * 0.1,
              child: const Text(
                'ستنتقل الان لمجموعة \nمن الالعاب ضمن تقييم \n SDQ  العالمي الخاص بالطفل',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.4 // لضبط تباعد الأسطر
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------
// أداة Custom Clipper لإنشاء الشكل المنحني (مطابقة لصفحة Child/done)
// ------------------------------------------------------------------

class SDQClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0); 
    path.lineTo(size.width, size.height); 

    // الانحناء من أسفل اليمين نحو اليسار
    var controlPoint = Offset(size.width * 0.4, size.height * 0.9);
    var endPoint = Offset(0, size.height * 0.6);
    
    // استخدام المنحنى الرباعي لعمل الشكل البيضاوي
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(0, 0); 
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}