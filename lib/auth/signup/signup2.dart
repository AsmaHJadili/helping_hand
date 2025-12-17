import 'package:flutter/material.dart';
import 'package:helping_hand/auth/signup/ٍsignup3child.dart';

// تعريف الألوان الجديدة بناءً على الصورة المرفقة
const Color primaryTeal = Colors.white; // لون الشكل المنحني في الأعلى
const Color darkBackground = Color.fromRGBO(70, 236, 213, 0.8); // لون خلفية التطبيق (التركوازي الغامق)
const Color buttonColor = Color(0xFF2A2D34); // لون زر "تسجيل الدخول"
const Color inputFillColor = Colors.white; // لون حقول الإدخال
const Color textColor = Color(0xFF2A2D34); // لون النصوص داخل الجزء العلوي

class Signup2 extends StatefulWidget {
  const Signup2({super.key});

  @override
  State<Signup2> createState() => _SignupState();
}

class _SignupState extends State<Signup2> {
  final _formKey = GlobalKey<FormState>();

  // Controllers للحقول المطلوبة في الصورة: البريد وكلمة المرور
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // حالة لإخفاء/إظهار كلمة المرور
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // دالة موحدة لإنشاء حقول الإدخال
  Widget _buildInputField({
    required String labelText,
    required TextEditingController controller,
    required TextInputType keyboardType,
    bool isPassword = false, // لتحديد ما إذا كان الحقل لكلمة المرور
    bool isConfirmPassword = false, // لتحديد حقل تأكيد كلمة المرور
  }) {
    // تحديد متغير الرؤية وتابع التبديل المناسب للحقل
    bool isVisible = isConfirmPassword ? _isConfirmPasswordVisible : _isPasswordVisible;
    Function toggleVisibility = () {
      setState(() {
        if (isConfirmPassword) {
          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
        } else {
          _isPasswordVisible = !_isPasswordVisible;
        }
      });
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان الحقل (مثل: البريد الإلكتروني)
          Padding(
            padding: const EdgeInsets.only(right: 15.0, bottom: 5),
            child: Text(
              labelText,
              style: const TextStyle(
                color: Colors.white, // لون النص الأبيض كما في التصميم الأصلي
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          // حقل الإدخال نفسه
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            textAlign: TextAlign.right, // محاذاة النص داخل الحقل لليمين
            obscureText: isPassword ? !isVisible : false, // إخفاء النص لكلمات المرور
            style: const TextStyle(color: Colors.black), // لون النص المدخل
            decoration: InputDecoration(
              filled: true,
              fillColor: inputFillColor,
              hintText: isPassword && !isConfirmPassword ? '123456789' : (labelText == 'البريد الإلكتروني' ? 'example@gmail.com' : null),
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              // أيقونة إظهار/إخفاء كلمة المرور
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        isVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () => toggleVisibility(),
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: buttonColor, width: 2), // حافة سوداء عند التركيز
              ),
            ),
            // منطق التحقق من صحة الإدخال
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'هذا الحقل مطلوب';
              }
              if (labelText == 'البريد الإلكتروني' && !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                return 'البريد الإلكتروني غير صحيح';
              }
              if (isConfirmPassword && value != passwordController.text) {
                return 'كلمة المرور غير متطابقة';
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
        backgroundColor: darkBackground, // لون الخلفية التركوازي الغامق
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
                      // حقل البريد الإلكتروني
                      _buildInputField(
                        labelText: 'البريد الإلكتروني',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      // حقل كلمة المرور
                      _buildInputField(
                        labelText: 'كلمة المرور',
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                      ),
                      // حقل أعد كتابة كلمة المرور
                      _buildInputField(
                        labelText: 'أعد كتابة كلمة المرور',
                        controller: confirmPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        isConfirmPassword: true,
                      ),

                      // نص الرسالة
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 50.0),
                        child: Text(
                          'سيتم ارسال رسالة ترحيبية الى بريدك الالكتروني',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ),
                      

                      // زر تسجيل الدخول
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // منطق التسجيل/تسجيل الدخول هنا
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('تم إدخال البيانات، جارٍ المتابعة...')),
                              );
                               Navigator.push(context, MaterialPageRoute(builder: (context) => const Signup3Child()));
                              // يمكنك هنا الانتقال إلى صفحة أخرى
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor, // لون الزر الأسود
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'تسجيل الدخول', // نص الزر كما في الصورة
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
    final screenWidth = MediaQuery.of(context).size.width;

    return ClipPath(
      clipper: SignupClipper(), // استخدام الـ Clipper المعدل
      child: Container(
        height: screenHeight * 0.35, // تقليل الارتفاع ليناسب الصورة المرفقة
        width: screenWidth,
        color: primaryTeal, // لون الخلفية الأبيض
        child: Stack(
          children: [
            // أيقونة الرجوع (تغيير اتجاه السهم ليناسب RTL)
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
              top: 100, // تعديل الموضع
              right: screenWidth * 0.1,
              left: screenWidth * 0.1,
              child: const Text(
                'تابع ادخال البيانات\nالخاصة بك', // النص الجديد
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // الشكل الدائري المظلل بالتركوازي في الزاوية العلوية اليمنى (الزاوية التي لم يغطها الـ clipper)
            Positioned(
              right: -50,
              top: -50,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: darkBackground.withOpacity(0.3), // التركوازي بشفافية
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
// أداة Custom Clipper لإنشاء الشكل المنحني في الأسفل ليناسب الصورة
// الشكل في الصورة يتجه من الزاوية السفلية اليسرى إلى الوسط
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