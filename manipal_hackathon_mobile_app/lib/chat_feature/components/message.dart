import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:manipal_hackathon_mobile_app/chat_feature/chat_message_class.dart';
import 'package:manipal_hackathon_mobile_app/chat_feature/constants.dart';
import 'package:manipal_hackathon_mobile_app/utils/colours.dart';

import 'text_message.dart';

class Message extends StatelessWidget {
  const Message({Key? key, required this.message, required this.loading})
      : super(key: key);

  final ChatMessage message;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    Widget messageContent(ChatMessage message) {
      return TextMessage(message: message);
    }

    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/ai_chatbot.png",
                height: 32,
                width: 32,
              ),
            ),
            const SizedBox(width: 12),
          ],
          loading
              ? const SizedBox(
                  height: 32,
                  width: 32,
                  child: LoadingIndicator(
                    indicatorType: Indicator.lineScaleParty,
                    colors: [
                      Colors.purple,
                      greenColour,
                      Colors.red,
                      blueColour
                    ],
                    strokeWidth: 2,
                  ),
                )
              : messageContent(message),
          // if (message.isSender) MessageStatusDot(status: message.messageStatus)
        ],
      ),
    );
  }
}
