import 'package:flutter/material.dart';
import 'package:helping_hand/screens/game_controller_screen.dart';

import 'games/start1.dart';

// -----------------------------------------------------------------------
// الألوان المستخدمة (استنتاجًا من الصور المرفقة)
// -----------------------------------------------------------------------
const Color primaryTeal = Color(0xFF46ECDB); // لون الخلفية (التركوازي)
const Color darkBackground = Color(0xFF2A2D34); // لون الأزرار والخلفية الداكنة
const Color cardBackground = Color(
  0xFFF7F7F7,
); // لون خلفية بطاقة الأطفال (الرمادي الفاتح)

// -----------------------------------------------------------------------
// بيانات وهمية للأطفال (لاستخدامها في عرض الشبكة)
// -----------------------------------------------------------------------
class Child {
  final String name;
  // يمكن استبدال هذا برابط أو مسار صورة حقيقي
  final String imageUrl;

  Child(this.name, this.imageUrl);
}

final List<Child> dummyChildren = [
  // هذه الأسماء مأخوذة من الصورة المرفقة
  Child('سامي', 'assets/images/childs/child1.jpg'), // تم تصحيح .jpj إلى .jpg
  Child('محمد', 'assets/images/childs/child2.jpg'), // تم تصحيح .jpj إلى .jpg
  Child('سلمى', 'assets/images/childs/child3.jpg'), // تم تصحيح .jpj إلى .jpg
  Child('سما', 'assets/images/childs/child4.jpg'), // تم تصحيح .jpj إلى .jpg
];

// -----------------------------------------------------------------------
// المكون الرئيسي للصفحة
// -----------------------------------------------------------------------
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    // تحديد اتجاه النص الافتراضي لليمين لليسار (RTL)
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white, // خلفية الشاشة بيضاء
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. قسم الرأس والترحيب
                _buildHeader(),
                const SizedBox(height: 30),

                // 2. النص التحفيزي
                _buildGreetingText(),
                const SizedBox(height: 40),

                // 3. شبكة الأطفال
                Expanded(child: _buildChildrenGrid(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // -----------------------------------------------------------------------
  // بناء رأس الصفحة (Header)
  // -----------------------------------------------------------------------
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // رسالة الترحيب

        // صورة المستخدم (دائرة بلون فاتح بدلاً من الصورة الفعلية)
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: cardBackground, // لون خفيف خلف الصورة
            shape: BoxShape.circle,
            image: const DecorationImage(
              // يجب استبدال هذا برابط أو مسار صورة المستخدم
              image: AssetImage('assets/images/parentPhoto.jpg'),
              fit: BoxFit.cover,
            ),
            border: Border.all(color: Colors.grey.shade500, width: 1.0),
          ),
        ),
        const Text(
          'مرحباً محمد . صباح الخير',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  // -----------------------------------------------------------------------
  // بناء النص التحفيزي
  // -----------------------------------------------------------------------
  Widget _buildGreetingText() {
    return const Text(
      'ابدأ يومك بتفقد صحة\nأطفالك النفسية',
      textAlign: TextAlign.right,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        height: 1.4,
      ),
    );
  }

  // -----------------------------------------------------------------------
  // بناء بطاقة عرض الأطفال
  // -----------------------------------------------------------------------
  Widget _buildChildrenGrid(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 236, 236, 236),
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 114, 114, 114).withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // عنوان الشبكة
          const Text(
            'أبنائي',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: darkBackground,
            ),
          ),
          const SizedBox(height: 20),

          // شبكة الصور (GridView)
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(), // منع التمرير
              itemCount: dummyChildren.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // عمودان
                childAspectRatio: 0.85, // لتناسب الاسم أسفل الصورة
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
              ),
              itemBuilder: (context, index) {
                final child = dummyChildren[index];
                // **التعديل هنا:** تمرير context إلى _buildChildCard
                return _buildChildCard(context, child);
              },
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // بناء بطاقة الطفل الواحدة
  // -----------------------------------------------------------------------
  // **التعديل هنا:** استقبال context كمعامل للدالة
  Widget _buildChildCard(BuildContext context, Child child) {
    return InkWell(
      onTap: () {
        // الانتقال إلى واجهة الألعاب (تم استخدام context الذي تم استقباله)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Start1()),
        );
      }, // 2. عند النقر، استدعِ دالة الانتقال إلى شاشة الألعاب
      borderRadius: BorderRadius.circular(
        10,
      ), // لتبدو بشكل جميل مع تأثير النقر (Ripple)
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // الصورة (دائرة)
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // استخدام AssetImage أو NetworkImage حسب الحاجة
              image: DecorationImage(
                // يجب استبدال هذا بمسارات صور فعلية
                image: AssetImage(
                  child.imageUrl.replaceAll('.jpj', '.jpg'),
                ), // تم تعديل .jpj إلى .jpg
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.grey.shade300, width: 2.0),
            ),
            // هذا هو المكان الذي يمكنك وضع الصور التي رأيتها في ملف child.PNG
          ),
          const SizedBox(height: 10),
          // الاسم
          Text(
            child.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
