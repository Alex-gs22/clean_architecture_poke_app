import 'package:flutter/material.dart';

class PokemonDetailHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const PokemonDetailHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(88);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onBackground = theme.colorScheme.onSurface;
    final isDark = theme.brightness == Brightness.dark;
    final circleColor =
        isDark ? theme.colorScheme.primary : const Color(0xFFF8D7DA);
    const iconColor = Colors.white;

    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        color: theme.colorScheme.background,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _BackButton(circleColor: circleColor, iconColor: iconColor),
            Expanded(
              child: Center(
                child: Text(
                  'Detalles del Pokémon',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: onBackground,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 52),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({
    required this.circleColor,
    required this.iconColor,
  });

  final Color circleColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 52,
      child: Material(
        color: circleColor,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => Navigator.of(context).maybePop(),
          child: Icon(
            Icons.arrow_back,
            color: iconColor,
            size: 26,
          ),
        ),
      ),
    );
  }
}
