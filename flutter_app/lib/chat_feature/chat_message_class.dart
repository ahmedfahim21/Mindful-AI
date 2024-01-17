class ChatMessage {
  final String text;
  final bool isSender;

  const ChatMessage({
    this.text = '',
    required this.isSender,
  });
}
