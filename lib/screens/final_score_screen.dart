import 'package:flutter/material.dart';
import '../services/shared_prefs_service.dart';
import '../utils/app_constants.dart';

class FinalScoreScreen extends StatefulWidget {
  const FinalScoreScreen({super.key});

  @override
  State<FinalScoreScreen> createState() => _FinalScoreScreenState();
}

class _FinalScoreScreenState extends State<FinalScoreScreen> {
  int _difficultyScore = 0;
  int _prosocialScore = 0;
  String _referralDecision = '';

  @override
  void initState() {
    super.initState();
    _loadFinalScores();
  }

  // جلب النتائج وتحديد قرار الإحالة
  void _loadFinalScores() async {
    final prefsService = SharedPreferencesService();
    final difficultyScore = await prefsService.getCurrentDifficultyScore();
    final prosocialScore = await prefsService.getCurrentProsocialScore();
    
    String decision;
    Color color;
    
    // منطق الإحالة المعتمد على مجموع الصعوبة (4 أبعاد) [cite: 10, 11, 12, 22]
    if (difficultyScore >= 17) {
      decision = 'غير طبيعي (مرتفع إكلينيكياً) - إحالة ضرورية.'; // [cite: 12, 13, 22]
      color = Colors.red;
    } else if (difficultyScore >= 14) {
      decision = 'حدي (Borderline) - توصية بمتابعة إضافية.'; // [cite: 11, 22]
      color = Colors.orange;
    } else {
      decision = 'عادي (Normal) - لا يحتاج إلى إحالة.'; // [cite: 10, 22]
      color = Colors.green;
    }

    setState(() {
      _difficultyScore = difficultyScore;
      _prosocialScore = prosocialScore;
      _referralDecision = decision;
    });
    
    // يتم مناقشة النتيجة مع الأخصائي وولي الأمر [cite: 22]
  }

  Widget _buildScoreCard(String title, int score, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: whiteBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: [
          Text(title, 
          // style: appTextStyle.copyWith(fontSize: 16)
          ),
          const SizedBox(height: 10),
          Text('$score', 
          // style: appTextStyle.copyWith(fontSize: 40, color: color)
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: primaryTeal,
        appBar: AppBar(
          backgroundColor: primaryTeal,
          elevation: 0,
          title: Text('نتائج التقييم النهائي',
          //  style: appTextStyle.copyWith(color: darkButtonColor)
           ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // قرار الإحالة
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: whiteBackground,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                  ),
                  child: Column(
                    children: [
                      Text('قرار الإحالة المعتمد (مجموع الصعوبة):', 
                      // style: appTextStyle.copyWith(fontSize: 20)
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _referralDecision,
                        textAlign: TextAlign.center,
                        // style: appTextStyle.copyWith(fontSize: 22, color: _difficultyScore >= 17 ? Colors.red : Colors.green, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text('النتيجة الكلية للصعوبة: $_difficultyScore / 40', 
                      // style: appTextStyle.copyWith(fontSize: 16, color: Colors.grey)
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                
                // تفصيل النتائج
                Row(
                  children: [
                    Expanded(child: _buildScoreCard('مجموع أبعاد الصعوبة (4)', _difficultyScore, Colors.red.shade700)),
                    const SizedBox(width: 15),
                    Expanded(child: _buildScoreCard('مجموع سلوكيات القوة (1)', _prosocialScore, Colors.green.shade700)),
                  ],
                ),
                
                const SizedBox(height: 30),
                
                ElevatedButton(
                  onPressed: () {
                    // العودة إلى الشاشة الرئيسية أو صفحة بيانات الطفل بعد إنهاء التقييم
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  ),
                  child: Text('العودة والإنهاء', 
                  // style: appTextStyle.copyWith(color: whiteBackground, fontSize: 18)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}