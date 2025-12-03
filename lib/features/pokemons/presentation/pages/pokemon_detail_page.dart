import 'package:clean_architecture_poke_app/features/pokemons/presentation/bloc/detail/pokemon_detail_bloc.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/widgets/pokemon_detail_header.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/widgets/pokemon_detail_stats_card.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/widgets/pokemon_detail_summary_card.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/widgets/app_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({
    super.key,
    required this.pokemonId,
  });

  final int pokemonId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: const PokemonDetailHeader(),
      body: BlocConsumer<PokemonDetailBloc, PokemonDetailState>(
        listenWhen: (previous, current) =>
            current is PokemonDetailLoaded && current.statusMessage != null,
        listener: (context, state) {
          if (state is PokemonDetailLoaded && state.statusMessage != null) {
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
          if (state is PokemonDetailLoading || state is PokemonDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PokemonDetailError) {
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
          if (state is PokemonDetailLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PokemonDetailSummaryCard(pokemon: state.pokemon),
                  const SizedBox(height: 16),
                  PokemonDetailStatsCard(pokemon: state.pokemon),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (state.isCapturing || state.isProcessing)
                          ? null
                          : () => _action(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B4CCA),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: (state.isCapturing || state.isProcessing)
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              state.isCaptured ? 'Liberar' : 'Capturar',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
          }
          if (index == 1) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/captured', (route) => false);
          }
        },
      ),
    );
  }

  void _action(BuildContext context) {
    final state = context.read<PokemonDetailBloc>().state;
    if (state is! PokemonDetailLoaded) return;
    if (state.isCaptured) {
      context.read<PokemonDetailBloc>().add(PokemonDetailLiberateRequested());
    } else {
      context.read<PokemonDetailBloc>().add(PokemonDetailCaptureRequested());
    }
  }
}
