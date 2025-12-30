import 'package:flutter/material.dart';
import 'package:helping_hand/games/game2/situationA2.dart';

class SituationA1 extends StatefulWidget {
  const SituationA1({super.key});

  @override
  State<SituationA1> createState() => _SituationA1State();
}

class _SituationA1State extends State<SituationA1> {
  
  // دالة للانتقال إلى الصفحة التالية عند النقر
  void _navigateToNextPage() {
    // استبدل 'NextPage()' باسم الكلاس الخاص بصفحتك التالية
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SituationA2()),
    );
    debugPrint("تم النقر والانتقال للصفحة التالية");
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 1. نص الموقف العلوي
              const Text(
                'صديقك كسر لعبتك\nالمفضلة بالخطأ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.3,
                ),
              ),

              // 2. الصورة الرئيسية بحواف مستديرة وظل
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    './assets/images/games-images/game2/image21.jpg', // تأكدي من المسار في pubspec.yaml
                    height: screenHeight * 0.35,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: screenHeight * 0.35,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
                  ),
                ),
              ),

              // 3. سؤال "بماذا تشعر؟"
              const Text(
                'بماذا تشعر؟',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              // 4. خيارات المشاعر (الدوائر الملونة)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFeelingOption(
                    color: const Color(0xFFF44336), // أحمر
                    label: 'الغضب',
                    onTap: _navigateToNextPage,
                  ),
                  _buildFeelingOption(
                    color: const Color(0xFFFFEB3B), // أصفر
                    label: 'أتضايق قليلاً',
                    onTap: _navigateToNextPage,
                  ),
                  _buildFeelingOption(
                    color: const Color(0xFF00C853), // أخضر
                    label: 'أقول له\nلا بأس',
                    onTap: _navigateToNextPage,
                  ),
                ],
              ),
              
              // مساحة فارغة في الأسفل للتوازن
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ودجت مخصصة لبناء خيار الشعور (الدائرة + النص)
  Widget _buildFeelingOption({
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}