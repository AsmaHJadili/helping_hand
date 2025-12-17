enum DimensionType {
  difficulty,  // الأعراض الانفعالية، مشكلات التصرف، فرط النشاط، مشكلات الأقران
  prosocial    // سلوكيات القوة (يُستثنى من مجموع الصعوبة)
}

class QuestionItem {
  final String scenario; // نص الموقف
  final String? imagePath; // مسار الصورة المرتبطة
  // الخيارات: Key هو نص الخيار، Value هو النقطة المقابلة (0، 1، أو 2)
  final Map<String, int> options; 

  QuestionItem({
    required this.scenario,
    this.imagePath,
    required this.options,
  });
}

class GameScenario {
  final int id;
  final String title;
  final DimensionType type; // نوع البعد (صعوبة أو قوة)
  final List<QuestionItem> questions; // قائمة المواقف لكل لعبة
  
  GameScenario({
    required this.id,
    required this.title,
    required this.type,
    required this.questions,
  });
}