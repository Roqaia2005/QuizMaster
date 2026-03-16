class Question {
  final String question;
  final List<String> options;
  final String answer;

  Question({
    required this.question,
    required this.options,
    required this.answer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      options: List<String>.from(json['options']),
      answer: json['answer'],
    );
  }
}

class Category {
  final String name;
  final List<Question> questions;
  final String iconPath;

  Category({
    required this.name,
    required this.questions,
    required this.iconPath,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    // Fix SVG path if it uses old path structure
    String iconPath = json['iconPath'];
    if (iconPath.contains('assets/svg/')) {
      iconPath = iconPath.replaceAll('assets/svg/', 'assets/svgs/');
    }
    
    return Category(
      name: json['name'],
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
      iconPath: iconPath,
    );
  }
}

class QuizData {
  final List<Category> categories;

  QuizData({required this.categories});

  factory QuizData.fromJson(Map<String, dynamic> json) {
    return QuizData(
      categories: (json['categories'] as List)
          .map((c) => Category.fromJson(c))
          .toList(),
    );
  }
}
