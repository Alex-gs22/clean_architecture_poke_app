import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surface = theme.colorScheme.surface;
    final shadow = theme.brightness == Brightness.dark
        ? Colors.black.withOpacity(0.3)
        : const Color(0x14000000);
    return Container(
      height: 116,
      decoration: BoxDecoration(
        color: surface,
        boxShadow: [
          BoxShadow(
            color: shadow,
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
    child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 28,
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: currentIndex,
            onTap: onTap,
            selectedItemColor: const Color(0xFF3B4CCA),
            unselectedItemColor: const Color(0xFF8A8FA3),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Buscar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.inventory_2_outlined),
                label: 'Capturados',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
