import 'package:appcentflutterassignment/provider/tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabView extends StatelessWidget {
  const TabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: context.watch<TabProvider>().currentIndex,
        onTap: (index) {
          context.read<TabProvider>().changeIndex(index);
        },
      ),
      body: context
          .read<TabProvider>()
          .pages[context.read<TabProvider>().currentIndex],
    );
  }
}
