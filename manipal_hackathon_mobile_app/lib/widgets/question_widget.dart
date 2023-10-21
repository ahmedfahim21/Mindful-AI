import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:manipal_hackathon_mobile_app/utils/colours.dart';
import 'package:manipal_hackathon_mobile_app/utils/questions.dart';
import 'package:manipal_hackathon_mobile_app/widgets/question_slider_widget.dart';

class QuestionWidget extends StatefulWidget {
  final String question;
  final String questionEmoji;
  final int questionNumber;
  final int totalQuestions;
  final Function(int) updateAnswer;
  final Function() submitAnswer;
  final CarouselController controller;

  const QuestionWidget(
      {super.key,
      required this.question,
      required this.questionEmoji,
      required this.questionNumber,
      required this.totalQuestions,
      required this.updateAnswer,
      required this.submitAnswer,
      required this.controller});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: widget.question.split('').length > 120 ? 50 : 60,
          horizontal: 20),
      child: Column(
        children: [
          Text(
            "Question ${widget.questionNumber + 1}",
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          if (widget.questionNumber + 1 == totalQuestionsNumber / 2) ...{
            Text(
              "You're Halfway done 🎉",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.grey[400]),
            ),
          } else if(widget.questionNumber + 1 == totalQuestionsNumber) ...{
            Text(
              "Finally, the last question 🥳",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.grey[400]),
            )
          } 
          else if (widget.questionNumber + 1 + 4 >= totalQuestionsNumber) ...{
            Text(
              "Almost there, Good Job 🙌",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.grey[400]),
            )
          } else ...{
            Container(),
          },
          SizedBox(
            height: widget.questionNumber == 0 ? 20 : 40,
          ),
          Text(
            "${widget.questionEmoji} ${widget.question}",
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: widget.question.split('').length > 120 ? 18 : 20),
          ),
          SizedBox(
            height: widget.question.split('').length > 120 ? 30 : 40,
          ),
          Expanded(
              child: QuestionSliderWidget(
            controller: widget.controller,
            questionNumber: widget.questionNumber,
            totalQuestions: widget.totalQuestions,
            updateAnswer: widget.updateAnswer,
            submitAnswer: widget.submitAnswer,
            emotionEmojis: widget.questionNumber == 0
                ? firstQuestionAnswerEmojis
                : questionAnswerEmojis,
            emotionNames: widget.questionNumber == 0
                ? firstQuestionAnswerNames
                : questionAnswerNames,
          )),
        ],
      ),
    );
  }
}
