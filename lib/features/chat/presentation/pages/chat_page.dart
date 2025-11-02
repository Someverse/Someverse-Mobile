import 'package:flutter/material.dart';

/// 채팅 탭 진입용 페이지 (stub)
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('채팅')), 
      body: const Center(child: Text('Chat Page')),
    );
  }
} 