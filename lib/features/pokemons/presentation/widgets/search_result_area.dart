import 'package:clean_architecture_poke_app/features/pokemons/presentation/bloc/search/search_pokemon_bloc.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/widgets/pokemon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultArea extends StatelessWidget {
  const SearchResultArea({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<SearchPokemonBloc, SearchPokemonState>(
      listenWhen: (previous, current) =>
          current is SearchPokemonLoaded && current.statusMessage != null,
      listener: (context, state) {
        if (state is SearchPokemonLoaded && state.statusMessage != null) {
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
        if (state is SearchPokemonLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SearchPokemonError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Icon(
                  Icons.info_outline,
                  color: Color(0xFF3B4CCA),
                  size: 40,
                ),
                const SizedBox(height: 12),
                Text(
                  state.message,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF1F2A44),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        if (state is SearchPokemonLoaded) {
          return PokemonCard(
            pokemon: state.pokemon,
            isCapturing: state.isCapturing,
            isCaptured: state.isCaptured,
            onCapture: () => context
                .read<SearchPokemonBloc>()
                .add(CapturePokemonRequested(state.pokemon)),
            onViewDetails: () => Navigator.of(context).pushNamed(
              '/pokemon_detail',
              arguments: {
                'id': state.pokemon.id,
                'captured': state.isCaptured,
              },
            ),
          );
        }
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 42),
              Container(
                width: 94,
                height: 94,
                decoration: const BoxDecoration(
                  color: Color(0xFF3B4CCA),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Busca tu Pokémon',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1F2A44),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Ingresa un ID o prueba con uno aleatorio',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF6E7385),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
