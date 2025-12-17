import 'package:flutter/material.dart';
// يجب التأكد من وجود هذه الصفحة للمتابعة
import 'package:helping_hand/auth/signup/ٍsignup3child.dart';
import 'package:helping_hand/formQus/ershad1.dart';

// تعريف الألوان الجديدة بناءً على الصورة المرفقة
const Color primaryTeal = Colors.white; // لون الشكل المنحني في الأعلى (الأبيض)
const Color darkBackground = Color.fromRGBO(70, 236, 213, 0.8); // لون خلفية التطبيق (التركوازي الغامق)
const Color buttonColor = Color(0xFF2A2D34); // لون زر "حفظ" (الأسود الداكن)
const Color inputFillColor = Color(0xFFE6F5F2); // لون حقول الإدخال (الأخضر الفاتح جدًا/الأبيض)

// ملاحظة: تم تغيير اسم الفئة إلى Signup3ChildScreen لتجنب التضارب مع الاسم الذي تم إرساله سابقًا
class Signup3Child extends StatefulWidget {
  const Signup3Child({super.key});

  @override
  State<Signup3Child> createState() => _SignupState();
}

class _SignupState extends State<Signup3Child> {
  final _formKey = GlobalKey<FormState>();

  // Controllers للحقول الجديدة: الاسم، رقم الهوية، الجنس (اختياري)، تاريخ الميلاد
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dobController = TextEditingController(); // تاريخ الميلاد

  // لإدارة قيمة حقل الجنس إذا كان سيتغير إلى قائمة منسدلة أو Date Picker لحقل تاريخ الميلاد
  String? _selectedGender;
  DateTime? _selectedDate;


  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    genderController.dispose();
    dobController.dispose();
    super.dispose();
  }

  // دالة موحدة لإنشاء حقول الإدخال القياسية (الاسم ورقم الهوية)
  Widget _buildInputField({
    required String labelText,
    required TextEditingController controller,
    required TextInputType keyboardType,
    Widget? suffixIcon,
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
                color: Colors.white, // لون النص الأبيض كما في الصورة
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
            readOnly: labelText == 'تاريخ الميلاد', // تاريخ الميلاد للقراءة فقط (لفتح الـ Date Picker)
            style: const TextStyle(color: Colors.black),
            onTap: labelText == 'تاريخ الميلاد' ? _presentDatePicker : null,
            decoration: InputDecoration(
              filled: true,
              fillColor: inputFillColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: buttonColor, width: 2),
              ),
            ),
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

  // دالة اختيار التاريخ
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        dobController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    });
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
                      // حقل الاسم
                      _buildInputField(
                        labelText: 'الاسم',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                      ),
                      // حقل رقم الهوية
                      _buildInputField(
                        labelText: 'رقم الهوية',
                        controller: idController,
                        keyboardType: TextInputType.number,
                      ),
                      // حقل الجنس (باستخدام Dropdown لتجربة خيار مختلف)
                      _buildGenderField(),
                      
                      // حقل تاريخ الميلاد
                      _buildInputField(
                        labelText: 'تاريخ الميلاد',
                        controller: dobController,
                        keyboardType: TextInputType.datetime,
                        // إضافة أيقونة للتقويم
                        suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey, size: 20),
                      ),
                      
                      const SizedBox(height: 50),

                      // زر حفظ
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('تم حفظ بيانات الطفل، جارٍ المتابعة...')),
                              );
                              // منطق الانتقال إلى الصفحة التالية بعد الحفظ
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SDQIntroScreen()));
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
                            'حفظ', // نص الزر الجديد
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

  // دالة بناء حقل الجنس كقائمة منسدلة (مطابقة للتصميم كحقل عادي لكن بوظيفة اختيار)
  Widget _buildGenderField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, bottom: 5),
            child: Text(
              'الجنس',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: inputFillColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: const InputDecoration(
                border: InputBorder.none, // إزالة الخط الافتراضي
                contentPadding: EdgeInsets.symmetric(vertical: 15),
              ),
              hint: const Text('اختر الجنس', textAlign: TextAlign.right, style: TextStyle(color: Colors.grey)),
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
              items: <String>['ذكر', 'أنثى'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, textAlign: TextAlign.right, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedGender = newValue;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'هذا الحقل مطلوب';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  // بناء الجزء العلوي بالشكل المنحني
  Widget _buildCurvedHeader(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ClipPath(
      clipper: ChildSignupClipper(), // استخدام Clipper الخاص بصفحة الطفل
      child: Container(
        height: screenHeight * 0.35,
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
                'أهلاً وسهلاً بك !\nقم الان بادخال بيانات\n طفلك', // النص الجديد
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
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
// أداة Custom Clipper لإنشاء الشكل المنحني الجديد (صفحة الطفل)
// ------------------------------------------------------------------

class ChildSignupClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0); // ابدأ من الزاوية العلوية اليمنى

    // الانحناء الأكبر والأبرز إلى الزاوية السفلية اليسرى
    path.lineTo(size.width, size.height); 

    // البدء من أسفل اليسار والانحناء نحو الأعلى
    var controlPoint = Offset(size.width * 0.4, size.height * 0.9);
    var endPoint = Offset(0, size.height * 0.6);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(0, 0); // العودة إلى نقطة البداية (الزاوية العلوية اليسرى)
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}