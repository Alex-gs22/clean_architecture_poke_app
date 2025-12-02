import 'package:flutter/material.dart';

class SearchBottomNavBar extends StatelessWidget {
  const SearchBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (_) {},
      selectedItemColor: const Color(0xFF3B4CCA),
      unselectedItemColor: const Color(0xFF8A8FA3),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory_2_outlined),
          label: 'Capturados',
        ),
      ],
    );
  }
}
