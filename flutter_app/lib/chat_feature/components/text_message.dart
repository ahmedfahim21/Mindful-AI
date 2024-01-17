import 'package:flutter/material.dart';
import 'package:manipal_hackathon_mobile_app/chat_feature/chat_message_class.dart';
import 'package:manipal_hackathon_mobile_app/chat_feature/constants.dart';
import 'package:manipal_hackathon_mobile_app/utils/colours.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  final ChatMessage? message;

  String wrapText(String input, int lineLength) {
    final words = input.split(' ');
    final List<String> lines = [];

    String currentLine = '';
    for (final word in words) {
      if ((currentLine.length + word.length) <= lineLength) {
        if (currentLine.isNotEmpty) {
          currentLine += ' ';
        }
        currentLine += word;
      } else {
        lines.add(currentLine);
        currentLine = word;
      }
    }

    if (currentLine.isNotEmpty) {
      lines.add(currentLine);
    }

    return lines.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: PhysicalModel(
        color: Colors.white,
        elevation: 5,
        shadowColor: blueColour,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding * 0.75,
            vertical: kDefaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: message!.isSender
                ? blueColour.withOpacity(0.7)
                : kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            wrapText(message!.text, 30),
            style: TextStyle(
              color: message!.isSender
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ),
      ),
    );
  }
}
