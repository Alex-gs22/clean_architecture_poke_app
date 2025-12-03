import 'package:clean_architecture_poke_app/features/pokemons/presentation/bloc/captured/captured_pokemons_bloc.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/widgets/captured_header.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/widgets/captured_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CapturedPokemonsPage extends StatelessWidget {
  const CapturedPokemonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: BlocConsumer<CapturedPokemonsBloc, CapturedPokemonsState>(
          listenWhen:
              (previous, current) =>
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
              return Center(
                child: Text(
                  state.message,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF1F2A44),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }
            if (state is CapturedPokemonsLoaded) {
              final pokemons = state.pokemons;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CapturedHeader(count: pokemons.length),
                    const SizedBox(height: 16),
                    Expanded(
                      child:
                          pokemons.isEmpty
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
                                      context
                                          .read<CapturedPokemonsBloc>()
                                          .add(CapturedPokemonsRequested());
                                    }
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              color: Color(0xFFE6E9F4),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              color: Color(0xFF3B4CCA),
              size: 38,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'No hay Pokémon\'s capturados',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1F2A44),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Captura algunos para verlos aquí',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF6E7385)),
          ),
        ],
      ),
    );
  }
}
