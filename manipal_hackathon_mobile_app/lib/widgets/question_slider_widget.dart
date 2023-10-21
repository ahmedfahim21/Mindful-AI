import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:manipal_hackathon_mobile_app/utils/colours.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class QuestionSliderWidget extends StatefulWidget {
  final Function(int) updateAnswer;
  final Function() submitAnswer;
  final List<String> emotionEmojis;
  final List<String> emotionNames;
  final int questionNumber;
  final int totalQuestions;
  final CarouselController controller;
  const QuestionSliderWidget(
      {super.key,
      required this.controller,
      required this.updateAnswer,
      required this.emotionEmojis,
      required this.emotionNames,
      required this.submitAnswer,
      required this.questionNumber,
      required this.totalQuestions});

  @override
  State<QuestionSliderWidget> createState() => _QuestionSliderWidgetState();
}

class _QuestionSliderWidgetState extends State<QuestionSliderWidget> {
  double chosenEmoji = 2;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.emotionNames.length,
                  itemExtent: 80,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Center(
                        child: Text(
                          widget.emotionNames[index],
                          style: TextStyle(
                              fontWeight:
                                  widget.emotionNames.length - 1 - index ==
                                          chosenEmoji
                                      ? FontWeight.bold
                                      : FontWeight.w600,
                              fontSize:
                                  widget.emotionNames.length - 1 - index ==
                                          chosenEmoji
                                      ? 22
                                      : 18,
                              color: widget.emotionNames.length - 1 - index ==
                                      chosenEmoji
                                  ? black
                                  : Colors.grey[500]?.withOpacity(1 -
                                      0.2 *
                                          ((widget.emotionNames.length -
                                                  1 -
                                                  chosenEmoji -
                                                  index)
                                              .abs()))),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.emotionEmojis.length,
                  itemExtent: 80,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Center(
                        child: Text(
                          widget.emotionEmojis[index],
                          style: TextStyle(
                            fontWeight:
                                widget.emotionEmojis.length - 1 - index ==
                                        chosenEmoji
                                    ? FontWeight.bold
                                    : FontWeight.w600,
                            fontSize: widget.emotionEmojis.length - 1 - index ==
                                    chosenEmoji
                                ? 26
                                : 22,
                            color: widget.emotionEmojis.length - 1 - index ==
                                    chosenEmoji
                                ? black
                                : Colors.grey[500]?.withOpacity(1 -
                                    0.2 *
                                        ((widget.emotionNames.length -
                                                1 -
                                                chosenEmoji -
                                                index)
                                            .abs())),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2.4,
          child: SfSliderTheme(
            data: SfSliderThemeData(
                overlayColor: blueColour.withOpacity(0.2),
                thumbColor: Colors.white,
                thumbRadius: 15,
                thumbStrokeWidth: 6,
                thumbStrokeColor: greenColour,
                activeTrackColor: greenColour,
                inactiveTrackColor: greenColour.withOpacity(0.2),
                overlayRadius: 20,
                activeTrackHeight: 12,
                inactiveTrackHeight: 10),
            child: SizedBox(
              height: (widget.emotionEmojis.length == 5)
                  ? MediaQuery.of(context).size.height * 0.55
                  : MediaQuery.of(context).size.height * 0.44,
              child: SfSlider.vertical(
                  stepSize: 1,
                  min: 0,
                  max: widget.emotionEmojis.length - 1,
                  value: chosenEmoji,
                  onChanged: (newValue) {
                    setState(() {
                      chosenEmoji = newValue;
                    });
                  }),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RawMaterialButton(
                  elevation: 4,
                  fillColor: greenColour,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 12.0),
                  onPressed: () {
                    if (widget.questionNumber < widget.totalQuestions - 1) {
                      widget.updateAnswer(chosenEmoji.toInt());
                      widget.controller.nextPage();
                    } else {
                      widget.submitAnswer();
                    }
                  },
                  child: Text(
                    widget.questionNumber + 1 == widget.totalQuestions
                        ? "Submit"
                        : "Continue",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
