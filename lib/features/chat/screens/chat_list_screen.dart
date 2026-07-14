import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../../providers/chat_provider.dart';
import '../widgets/chat_tile.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: ListView.separated(
        scrollCacheExtent: const ScrollCacheExtent.pixels(600),
        itemCount: provider.chats.length,
        separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
        itemBuilder: (context, index) {
          final chat = provider.chats[index];
          return ChatTile(key: ValueKey(chat.id), chat: chat);
        },
      ),
    );
  }
}
