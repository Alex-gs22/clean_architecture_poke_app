import 'package:clean_architecture_poke_app/features/pokemons/presentation/bloc/captured/captured_pokemons_bloc.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/widgets/captured_header.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/widgets/captured_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CapturedPokemonsPage extends StatelessWidget {
  const CapturedPokemonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final background = Theme.of(context).colorScheme.surface;
    final orientation = MediaQuery.of(context).orientation;
    return ColoredBox(
      color: background,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth;
            if (constraints.maxWidth > 900) {
              maxWidth = 900;
            } else if (constraints.maxWidth > 600) {
              maxWidth = 720;
            } else {
              maxWidth = 480;
            }
            final double horizontal = (constraints.maxWidth - maxWidth) / 2;
            final double safeHorizontal =
                horizontal.clamp(20.0, constraints.maxWidth);
            final double verticalPadding =
                orientation == Orientation.landscape ? 12 : 24;

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: safeHorizontal,
                vertical: verticalPadding,
              ),
              child: BlocConsumer<CapturedPokemonsBloc, CapturedPokemonsState>(
                listenWhen: (previous, current) =>
                    current is CapturedPokemonsLoaded &&
                    current.statusMessage != null,
                listener: (context, state) {
                  if (state is CapturedPokemonsLoaded &&
                      state.statusMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.statusMessage!),
                        backgroundColor:
                            state.isStatusError ? Colors.redAccent : Colors.green,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CapturedPokemonsLoading ||
                      state is CapturedPokemonsInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CapturedPokemonsError) {
                    final isDark =
                        Theme.of(context).colorScheme.brightness == Brightness.dark;
                    return Center(
                      child: Text(
                        state.message,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: isDark ? Colors.white : const Color(0xFF1F2A44),
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    );
                  }
                  if (state is CapturedPokemonsLoaded) {
                    final pokemons = state.pokemons;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CapturedHeader(count: pokemons.length),
                        const SizedBox(height: 16),
                        Expanded(
                          child: pokemons.isEmpty
                              ? _EmptyState()
                              : ListView.separated(
                                  itemCount: pokemons.length,
                                  separatorBuilder:
                                      (_, __) => const SizedBox(height: 14),
                                  itemBuilder: (context, index) {
                                    final pokemon = pokemons[index];
                                    return CapturedListItem(
                                      pokemon: pokemon,
                                      onTap: () async {
                                        final result = await Navigator.of(context)
                                            .pushNamed(
                                          '/pokemon_detail',
                                          arguments: {
                                            'id': pokemon.id,
                                            'captured': true,
                                          },
                                        );
                                        if (result == true && context.mounted) {
                                          BlocProvider.of<CapturedPokemonsBloc>(
                                            context,
                                          ).add(CapturedPokemonsRequested());
                                        }
                                      },
                                    );
                                  },
                                ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.colorScheme.brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              color: isDark ? Colors.white : theme.colorScheme.primary,
              size: 36,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No hay Pokémon capturados',
            style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : theme.colorScheme.onSurface),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Captura algunos para verlos aquí',
            style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
