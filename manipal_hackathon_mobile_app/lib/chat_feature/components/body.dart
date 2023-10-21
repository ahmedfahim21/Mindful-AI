import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';
import 'package:manipal_hackathon_mobile_app/chat_feature/chat_message_class.dart';
import 'package:manipal_hackathon_mobile_app/chat_feature/constants.dart';
import 'package:manipal_hackathon_mobile_app/utils/colours.dart';
import 'dart:convert';
import 'message.dart';

const OPEN_AI_API_KEY = "";

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> messages = [];
  bool waiting = false;

  List<Map<String, dynamic>> chatMessagesToJsonList(
      List<ChatMessage> messages) {
    final temp = messages.map((message) {
      return {
        'role': message.isSender ? 'user' : 'assistant',
        'content': message.text,
      };
    }).toList();
    temp.insert(0, {
      'role': 'system',
      'content':
          "You are a friend of a college going student, just talk to him like a friend or companion and listen to all his talks, console him if necessary and don't reply like a bot. Keep your messages crisp and short, max 100",
    });
    return temp;
  }

  void _sendMessage(String text, bool isUser) {
    setState(() {
      messages.add(ChatMessage(
        text: text,
        isSender: isUser,
      ));
    });

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 1000,
      duration: const Duration(milliseconds: 30),
      curve: Curves.easeOut,
    );
  }

  Future<void> fetchResponse() async {
    setState(() {
      waiting = true;
      messages.add(const ChatMessage(isSender: false, text: ''));
    });
    String apiUrl = 'https://api.openai.com/v1/chat/completions';
    String serverResponse = "";
    Map<String, dynamic> jsonPayload = {
      "model": "gpt-3.5-turbo",
      "messages": chatMessagesToJsonList(messages)
    };

    print("JSON payload OPEN_AI API: $jsonPayload");

    final url = Uri.parse(apiUrl);

    // final response = await http.post(url,
    //     headers: {'Authorization': 'Bearer $OPEN_AI_API_KEY'},
    //     body: jsonPayload);
    final response = await Dio().postUri(url,
        data: jsonPayload,
        options: Options(
          headers: {'Authorization': 'Bearer $OPEN_AI_API_KEY'},
        ));

    if (response.statusCode == 200) {
      // Request was successful
      serverResponse =
          response.data["choices"][0]["message"]["content"].toString();
      print('Response data: ${serverResponse}');
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
    }

    setState(() {
      messages.removeAt(messages.length - 1);
      messages.add(ChatMessage(
        text: serverResponse,
        isSender: false,
      ));
      waiting = false;
    });

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 1000,
      duration: const Duration(milliseconds: 30),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sendMessage(
          "Hi, I'm your Mental Health Assistant. How can I help you?", false);
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: kDarkGreen.withOpacity(0.8),
              elevation: 10,
              shadowColor: blueColour,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                        text: "Your AI Friend!  ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: "👋",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ]),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return messages[index].text == ''
                          ? Message(message: messages[index], loading: true)
                          : Message(
                              message: messages[index],
                              loading: false,
                            );
                    }),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: null,
                        // textAlignVertical: TextAlignVertical.center,
                        controller: _messageController,
                        style: const TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding * 0.75, vertical: 15),
                          hintText: "Write your messages here...",
                          border: InputBorder.none,
                          fillColor: kDarkGreen.withOpacity(0.8),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return "Please enter some text";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: kDarkGreen.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          String message = _messageController.text;
                          _messageController.clear();
                          _sendMessage(message, true);
                          await fetchResponse();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
