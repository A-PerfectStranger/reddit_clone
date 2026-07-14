import 'package:flutter/material.dart';
import '../features/home/screens/home_screen.dart';
import '../features/communities/screens/communities_screen.dart';
import '../features/chat/screens/chat_list_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/create/screens/create_post_screen.dart';
import 'app_drawer.dart';

/// Contenedor principal con BottomNavigationBar (Home, Communities,
/// Create, Chat, Inbox), replicando la navegacion de Reddit.
/// Usa IndexedStack para preservar el estado de cada pestana.
class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _index = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final List<Widget> _screens = [
    HomeScreen(onMenuTap: () => _scaffoldKey.currentState?.openDrawer()),
    const CommunitiesScreen(),
    const SizedBox.shrink(), // Create abre un modal, no una pestana persistente
    const ChatListScreen(),
    const ProfileScreen(),
  ];

  void _onTap(int i) {
    if (i == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CreatePostScreen()),
      );
      return;
    }
    setState(() => _index = i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _onTap,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.groups_rounded), label: 'Communities'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), label: 'Create'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_rounded), label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_rounded), label: 'Inbox'),
        ],
      ),
    );
  }
}
