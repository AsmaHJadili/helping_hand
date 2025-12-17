import 'package:flutter/material.dart';
import 'package:helping_hand/formQus/ershad2.dart';

// تعريف الألوان المشتركة (مأخوذة من التصميمات السابقة)
const Color primaryTeal = Colors.white; // لون الشكل المنحني في الأعلى (الأبيض)
const Color darkBackground = Color.fromRGBO(70, 236, 213, 1); // لون خلفية التطبيق (التركوازي الغامق)
const Color buttonColor = Color(0xFF2A2D34); // لون زر "التالي" (الأسود الداكن)
const Color questionTextColor = Color(0xFF2A2D34); // لون نصوص الأسئلة (الأسود الداكن)
const Color answerCircleColor = Color(0xFF2A2D34); // لون دائرة اختيار الإجابة

// نموذج بيانات السؤال
class Question {
  final int id;
  final String text;
  String? selectedAnswer; // الإجابة المختارة (غير صحيح، صحيح نوعًا ما، صحيح بالتأكيد)

  Question({required this.id, required this.text, this.selectedAnswer});
}

class SDQ3 extends StatefulWidget {
  const SDQ3({super.key});

  @override
  State<SDQ3> createState() => _SDQFormScreenState();
}

class _SDQFormScreenState extends State<SDQ3> {

  // الخيارات الثابتة للإجابة
  final List<String> answerOptions = [
    'غير صحيح',
    'صحيح نوعا ما',
    'صحيح بالتأكيد',
  ];

  // قائمة الأسئلة (9 أسئلة كما طلب المستخدم)
  final List<Question> _questions = [
    Question(id: 18, text: 'كثيراً ما يكذب أو يخدع أو يغش'),
    Question(id: 19, text: 'يُستهزأ منه أو يستهزأ عليه من\n هم في سنه'),
    Question(id: 20, text: 'كثيراً ما يتطوع لمساعدة الآخرين \n(الوالدين، المدرسين، الأطفال الآخرين)'),
    Question(id: 21, text: 'يفكر قبل أن يتصرف'),
    Question(id: 22, text: 'يسرق من البيت أو المدرسة أو\n من أماكن أخرى'),
    Question(id: 23, text: 'ينسجم بشكل أفضل مع الكبار أكثر من\n الأطفال في سنه'),
    Question(id: 24, text: 'يخاف من أشياء كثيرة. من السهل تخويفه'),
    Question(id: 25, text: 'يتابع أداء الواجبات حتى النهاية. لديه انتباه جيد'),
  ];

  // دالة موحدة لبناء السؤال مع خيارات الإجابة
  Widget _buildQuestionItem(Question question) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // نص السؤال ورقمه
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Text(
              '${question.id}. ${question.text}:',
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: questionTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // خيارات الإجابة (Radio Buttons)
          ...answerOptions.map((option) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  question.selectedAnswer = option;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end, // محاذاة لليمين
                  children: [
                    Text(
                      option,
                      style: const TextStyle(
                        color: questionTextColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // شكل Radio Button مخصص 
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: answerCircleColor,
                          width: 2,
                        ),
                        color: question.selectedAnswer == option
                            ? Color.fromRGBO(70, 236, 213, 0.8)
                            : Colors.transparent,
                      ),
                      child: question.selectedAnswer == option
                          ? const Center(
                              child: Icon(Icons.circle, size: 10, color: Colors.white),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // دالة التحقق من إجابة جميع الأسئلة
  bool _areAllQuestionsAnswered() {
    return _questions.every((q) => q.selectedAnswer != null);
  }

  // بناء الجزء العلوي بالشكل المنحني
  Widget _buildCurvedHeader(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ClipPath(
      clipper: SDQClipper(), 
      child: Container(
        height: screenHeight * 0.25,
        width: screenWidth,
        color: primaryTeal,
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
              child: const Text(
                'اختر الإجابة التي تناسب السؤال:',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            // 1. الجزء العلوي بالشكل المنحني (Header)
            _buildCurvedHeader(context),

            // 2. قائمة الأسئلة
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return _buildQuestionItem(_questions[index]);
                },
              ),
            ),
            
            // 3. زر "التالي"
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_areAllQuestionsAnswered()) {
                      // منطق الانتقال للصفحة التالية من الاستبيان
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم إجابة الأسئلة. جارٍ الانتقال للصفحة التالية...')),
                      );
                      // يمكنك وضع كود الانتقال هنا:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Ershad2()));
                    } else {
                       ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('الرجاء الإجابة على جميع الأسئلة للمتابعة.'), backgroundColor: Colors.red),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'حفظ النتائج', // نص الزر هو 'التالي'
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
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
// أداة Custom Clipper للحفاظ على تصميم الرأس المنحني
// ------------------------------------------------------------------

class SDQClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0); 
    path.lineTo(size.width, size.height); 

    var controlPoint = Offset(size.width * 0.4, size.height * 0.9);
    var endPoint = Offset(0, size.height * 0.6);
    
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(0, 0); 
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}