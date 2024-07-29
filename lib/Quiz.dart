import 'package:flutter/material.dart';
import 'InputPage.dart';
import 'dart:math';

class Quiz extends StatefulWidget {
  final int number;
  final int startLimit;
  final int endLimit;

  Quiz({
    required this.number,
    required this.startLimit,
    required this.endLimit,
  });

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestionIndex = 0;
  bool showResult = false;
  bool isCorrect = false;
  String correctAnswer = '';

  List<Map<String, dynamic>> questions = [];

  @override
  void initState() {
    super.initState();
    generateQuestions();
  }

  void generateQuestions() {
    List<int> questionIndexes = List.generate(widget.endLimit - widget.startLimit + 1, (index) => widget.startLimit + index);
    questionIndexes.shuffle();

    for (int i = 0; i < min(5, questionIndexes.length); i++) {
      int questionIndex = questionIndexes[i];
      String questionText = '${widget.number} * $questionIndex = ?';
      String correctAnswer = (widget.number * questionIndex).toString();
      List<String> options = [
        correctAnswer,
        (widget.number * (questionIndex + 1)).toString(),
        (widget.number * (questionIndex + 2)).toString()
      ]..shuffle();

      questions.add({
        'question': questionText,
        'correctAnswer': correctAnswer,
        'options': options,
      });
    }
  }

  void checkAnswer(String selectedAnswer) {
    setState(() {
      showResult = true;
      isCorrect = selectedAnswer == questions[currentQuestionIndex]['correctAnswer'];
      correctAnswer = questions[currentQuestionIndex]['correctAnswer'];
    });
  }

  void nextQuestion() {
    setState(() {
      currentQuestionIndex = (currentQuestionIndex + 1) % questions.length;
      showResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int remainingQuestions = questions.length - currentQuestionIndex - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${remainingQuestions + 1} question${remainingQuestions > 0 ? "s" : ""} remaining',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    questions[currentQuestionIndex]['question'],
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
          ...questions[currentQuestionIndex]['options'].map<Widget>((option) {
            return GestureDetector(
              onTap: () {
                checkAnswer(option);
              },
              child: Container(
                color: Color(0xFFEB1555),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                padding: EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
          if (showResult)
            Container(
              child: Center(
                child: Text(
                  isCorrect
                      ? 'Correct!'
                      : 'You selected the wrong option. The correct answer is $correctAnswer.',
                  style: TextStyle(fontSize: 18, color: isCorrect ? Colors.green : Colors.red),
                ),
              ),
            ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Input()));
                    },
                    child: Container(
                      color: Color(0xFFEB1555),
                      child: Center(
                        child: Text(
                          "Generate Table",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: nextQuestion,
                    child: Container(
                      color: Color(0xFFEB1555),
                      child: Center(
                        child: Text(
                          "Next Question",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
