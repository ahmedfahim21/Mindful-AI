import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:manipal_hackathon_mobile_app/utils/colours.dart';
import 'package:manipal_hackathon_mobile_app/utils/questions.dart';
import 'package:manipal_hackathon_mobile_app/widgets/question_slider_widget.dart';
import 'package:manipal_hackathon_mobile_app/widgets/question_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> answers = [];
  CarouselController carouselController = CarouselController();

  void updateAnswer(int answer) {
    answers.add(answer);
  }

  void submitAnswers() {
    print(answers);
  }

  int pageNumber = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColour,
        // body: ListView.builder(itemBuilder: (context, index) {
        body: CarouselSlider.builder(
            carouselController: carouselController,
            itemCount: totalQuestionsNumber,
            itemBuilder: (context, index, realIndex) {
              return QuestionWidget(
                controller: carouselController,
                question: questions[index],
                questionEmoji: questionEmojis[index],
                questionNumber: index,
                totalQuestions: totalQuestionsNumber,
                updateAnswer: updateAnswer,
                submitAnswer: submitAnswers,
              );
            },
            options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                initialPage: pageNumber,
      ),))
    );
  }
}
