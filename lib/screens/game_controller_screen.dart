import 'package:flutter/material.dart';
import 'package:helping_hand/data/game_data.dart';
import 'package:helping_hand/models/game_scenario.dart';
import 'package:helping_hand/services/shared_prefs_service.dart';
import 'package:helping_hand/utils/app_constants.dart';
import 'package:helping_hand/screens/final_score_screen.dart';

class GameControllerScreen extends StatefulWidget {
  const GameControllerScreen({super.key});

  @override
  State<GameControllerScreen> createState() => _GameControllerScreenState();
}

class _GameControllerScreenState extends State<GameControllerScreen> {
  final PageController _pageController = PageController();
  final SharedPreferencesService _prefsService = SharedPreferencesService();
  
  // نحول قائمة الألعاب إلى قائمة أسئلة مسطحة (Flat List) لسهولة التمرير
  late final List<QuestionItem> _allQuestions;
  late final List<GameScenario> _gamesMetadata; // لحفظ بيانات اللعبة الأم لكل سؤال
  
  int _currentQuestionIndex = 0;
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _prefsService.clearAllScores(); // مسح النقاط عند بدء اختبار جديد
    _initializeQuestions();
  }
  
  // دمج جميع الأسئلة في قائمة واحدة مع الاحتفاظ ببيانات اللعبة الأم
  void _initializeQuestions() {
    _allQuestions = [];
    _gamesMetadata = [];
    for (var game in allGames) {
      for (var question in game.questions) {
        _allQuestions.add(question);
        _gamesMetadata.add(game); 
      }
    }
  }

  // ------------------------------------------------------------------
  // دالة حساب وتخزين النقاط والانتقال
  // ------------------------------------------------------------------
  void _handleNext() async {
    final currentQuestion = _allQuestions[_currentQuestionIndex];
    final parentGame = _gamesMetadata[_currentQuestionIndex];

    if (_selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء اختيار إجابة للمتابعة.'), backgroundColor: Color.fromARGB(255, 255, 177, 171)),
      );
      return;
    }

    // 1. حساب وتخزين النقاط
    final pointsToAdd = currentQuestion.options[_selectedOption!] ?? 0;
    final isProsocial = parentGame.type == DimensionType.prosocial;
    
    // إضافة النقاط حسب نوع البعد
    await _prefsService.addPoints(pointsToAdd, isProsocial);
    
    // 2. التحقق من نهاية الأسئلة
    final nextIndex = _currentQuestionIndex + 1;

    if (nextIndex < _allQuestions.length) {
      // الانتقال إلى السؤال التالي
      setState(() {
        _currentQuestionIndex = nextIndex;
        _selectedOption = null; // إعادة تعيين الخيار
      });
      _pageController.animateToPage(
        nextIndex, 
        duration: const Duration(milliseconds: 300), 
        curve: Curves.easeIn,
      );
    } else {
      // تم الانتهاء من جميع الأسئلة
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FinalScoreScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_allQuestions.isEmpty) {
      return const Scaffold(body: Center(child: Text('جاري تحميل البيانات...')));
    }
    
    // Timer Logic (Simplified) - You would need to manage the total 30 mins time limit here [cite: 1]
    
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: primaryTeal,
        appBar: AppBar(
          backgroundColor: primaryTeal,
          elevation: 0,
          title: Text(
            '${_gamesMetadata[_currentQuestionIndex].title} - موقف ${_currentQuestionIndex + 1}/${_allQuestions.length}',
            // style: appTextStyle.copyWith(fontSize: 16, color: darkButtonColor),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // لمنع التمرير باليد
                itemCount: _allQuestions.length,
                itemBuilder: (context, index) {
                  final question = _allQuestions[index];
                  final parentGame = _gamesMetadata[index];
                  
                  return _buildQuestionUI(question, parentGame);
                },
              ),
            ),
            
            // زر التالي
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                onPressed: _handleNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkButtonColor,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  _currentQuestionIndex < _allQuestions.length - 1 ? 'التالي' : 'إنهاء التقييم',
                  // style: appTextStyle.copyWith(fontSize: 20, color: whiteBackground),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionUI(QuestionItem question, GameScenario parentGame) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. منطقة الصورة والوصف
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: whiteBackground,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                // عرض الصورة (الافتراضية إذا لم يتم توفير مسار)
                if (question.imagePath != null) 
                  Image.asset(question.imagePath!), // يجب إضافة الصور إلى ملف assets
                if (question.imagePath == null)
                  Container(height: 150, color: Colors.grey[300], child: Center(child: Text('صورة الموقف'))),
                
                const SizedBox(height: 15),
                Text(
                  question.scenario,
                  textAlign: TextAlign.center,
                  // style: appTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.normal, height: 1.5),
                ),
                Text(
                  'اختر التصرف الأقرب إليك:',
                  textAlign: TextAlign.center,
                  // style: appTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 30),

          // 2. خيارات الإجابة
          ...question.options.keys.map((option) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedOption = option;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedOption == option ? darkButtonColor : lightTeal,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  option,
                  textAlign: TextAlign.center,
                  // style: appTextStyle.copyWith(
                  //   fontSize: 18,
                  //   color: _selectedOption == option ? whiteBackground : darkButtonColor,
                  // ),
                ),
              ),
            );
          }).toList(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}