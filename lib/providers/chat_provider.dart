import 'package:flutter/material.dart';
import '../models/chat_model.dart';
import '../mock/mock_data.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatModel> _chats = MockData.generateChats()
    ..sort((a, b) => b.time.compareTo(a.time));

  List<ChatModel> get chats => _chats;
}
