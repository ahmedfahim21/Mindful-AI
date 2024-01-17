import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:manipal_hackathon_mobile_app/utils/colours.dart';
import 'package:manipal_hackathon_mobile_app/utils/compute_daas_score.dart';
import 'package:manipal_hackathon_mobile_app/utils/questions.dart';
import 'package:manipal_hackathon_mobile_app/widgets/question_widget.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionnaireWidget extends StatefulWidget {
  const QuestionnaireWidget({super.key});

  @override
  State<QuestionnaireWidget> createState() => _QuestionnaireWidgetState();
}

class _QuestionnaireWidgetState extends State<QuestionnaireWidget> {
  List<int> answers = [];
  CarouselController carouselController = CarouselController();
  ValueNotifier<bool> submittingAnswers = ValueNotifier(false);

  void updateAnswer(int answer) {
    answers.add(answer);
  }

  void questionsAnsweredDialogBox() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  backgroundColor: backgroundColour,
                  child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(40.0, 25.0, 40.0, 40.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Lottie.asset("lottie/congratulations_lottie.json",
                              height: 200, width: 200),
                          const SizedBox(height: 20),
                          const Text(
                            "Good Job!!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                                color: greenColour),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "You have answered all the questions!",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text("Go Back",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: greenColour)))
                        ],
                      ))));
        });
  }

  void questionSubmittingDialogBox() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  backgroundColor: backgroundColour,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(40.0, 25.0, 40.0, 40.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20),
                        CircularProgressIndicator(
                          color: greenColour,
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Submitting Answers...",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: greenColour),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )));
        });
  }

  void submitAnswers() async {
    submittingAnswers.value = true;
    questionSubmittingDialogBox();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final scores = calculateDassScores(answers);
    CollectionReference users = firestore.collection('students');
    await users.doc(FirebaseAuth.instance.currentUser?.uid).set({
      "answers": answers,
      "scores": {
        "Depression": scores["Depression"],
        "Anxiety": scores["Anxiety"],
        "Stress": scores["Stress"],
      }
    });
    questionsAnsweredDialogBox();
    submittingAnswers.value = false;
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
                scrollPhysics: const NeverScrollableScrollPhysics(),
                height: MediaQuery.of(context).size.height,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                initialPage: pageNumber,
              ),
            )));
  }
}
