import 'package:flutter/material.dart';
import 'package:helping_hand/auth/signup/signup2.dart';
import 'package:shared_preferences/shared_preferences.dart';


// تعريف الألوان من التصميم المرفق
const Color primaryTeal = Colors.white; // اللون التركوازي الفاتح للجزء العلوي
const Color darkBackground = Color.fromRGBO(70, 236, 213, 0.8); // لون خلفية التطبيق (الداكن)
const Color buttonColor = Color(0xFF2A2D34); // لون زر "التالي"
const Color textColor = Colors.black; // لون النصوص داخل الجزء العلوي

class Signup1 extends StatefulWidget {
   const Signup1({super.key});

  @override
  State<Signup1> createState() => _SignupState();
}

class _SignupState extends State<Signup1> {
  final _formKey = GlobalKey<FormState>();

  final _isSignup = false ;
  // Controllers للحقول المطلوبة في التصميم
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController familyController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    phoneController.dispose();
    familyController.dispose();
    super.dispose();
  }

  // دالة موحدة لإنشاء حقول الإدخال
  Widget _buildInputField({
    required String labelText,
    required TextInputType keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان الحقل (مثل: الاسم)
          Padding(
            padding: const EdgeInsets.only(right: 15.0, bottom: 5),
            child: Text(
              labelText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          // حقل الإدخال نفسه
          TextFormField(
            keyboardType: keyboardType,
            textAlign: TextAlign.right, // محاذاة النص داخل الحقل لليمين
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: primaryTeal, width: 2),
              ),
            ),
            // مثال بسيط للتحقق من صحة الإدخال
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'هذا الحقل مطلوب';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // تحديد اتجاه المحتوى من اليمين لليسار
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: darkBackground, // لون الخلفية الداكن للتطبيق
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // 1. الجزء العلوي بالشكل المنحني (Header)
              _buildCurvedHeader(context),

              // 2. نموذج إدخال البيانات
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      // حقل الاسم
                      _buildInputField(
                        labelText: 'الاسم',
                        keyboardType: TextInputType.name,
                      ),
                      // حقل رقم الهوية
                      _buildInputField(
                        labelText: 'رقم الهوية',
                        keyboardType: TextInputType.number,
                      ),
                      // حقل رقم الجوال
                      _buildInputField(
                        labelText: 'رقم الجوال',
                        keyboardType: TextInputType.phone,
                      ),
                      // حقل عدد الأفراد
                      _buildInputField(
                        labelText: 'عدد الأفراد',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 50),

                      // زر التالي
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // منطق الانتقال إلى الصفحة التالية (مثلاً Homepage)
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Signup2()));
                              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                              sharedPreferences.setBool("isSignup", true);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('تم إدخال البيانات، جارٍ المتابعة...')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'التالي',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // بناء الجزء العلوي بالشكل المنحني
  Widget _buildCurvedHeader(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return ClipPath(
      clipper: SignupClipper(),
      child: Container(
        height: screenHeight * 0.45,
        color: primaryTeal, // لون الخلفية التركوازية الفاتحة
        child: Stack(
          children: [
            // أيقونة الرجوع
            Positioned(
              
              top: 40,
              left: 20,
              child: IconButton(
                
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 28),
                onPressed: () {
                  // منطق زر الرجوع
                  Navigator.pop(context); 
                },
              ),
            ),
            // النص الرئيسي
            const Positioned(
              top: 150,
              right: 40,
              child: Text(
                'أنشئ حسابك في\nالخطوات القليلة القادمة',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // الأشكال البيضاء المنحنية الصغيرة (لجعلها أقرب للتصميم)
            Positioned(
              left: -50,
              top: 0,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(70, 236, 213, 0.10),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: -10,
              top: 200,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(70, 236, 213, 0.10),
                  shape: BoxShape.circle,
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
// أداة Custom Clipper لإنشاء الشكل المنحني غير المنتظم (مطابقة للتصميم)
// ------------------------------------------------------------------

class SignupClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);

    // النقطة السفلية اليسرى (أول انحناء)
    var firstControlPoint = Offset(size.width * 0.15, size.height - 30);
    var firstEndPoint = Offset(size.width * 0.4, size.height - 50);
    path.quadraticBezierTo(
        firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    // النقطة الوسطى (انحناء داخلي)
    // var secondControlPoint = Offset(size.width * 0.5, size.height - 70);
    // var secondEndPoint = Offset(size.width * 0.65, size.height - 50);
    // path.quadraticBezierTo(
    //     secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    // النقطة السفلية اليمنى (آخر انحناء)
    var thirdControlPoint = Offset(size.width * 0.85, size.height - 30);
    var thirdEndPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(
        thirdControlPoint.dx, thirdControlPoint.dy, thirdEndPoint.dx, thirdEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}