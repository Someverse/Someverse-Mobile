import 'package:flutter/material.dart';
import 'package:someverse/features/chat/presentation/pages/chat_page.dart';
import 'package:someverse/features/matching/presentation/pages/match_page.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  int _currentIndex = 0;

  static const List<Widget> _pages = <Widget>[
    ChatPage(),
    MatchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: '매칭',
          ),
        ],
      ),
    );
  }
}
