import 'package:clean_architecture_poke_app/features/pokemons/domain/entities/pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/use_cases/capture_pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/use_cases/search_pokemon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pokemon_detail_event.dart';
part 'pokemon_detail_state.dart';

class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  PokemonDetailBloc({
    required this.searchPokemonUseCase,
    required this.capturePokemonUseCase,
  }) : super(PokemonDetailInitial()) {
    on<PokemonDetailRequested>(_onRequested);
    on<PokemonDetailCaptureRequested>(_onCapture);
  }

  final SearchPokemonUseCase searchPokemonUseCase;
  final CapturePokemonUseCase capturePokemonUseCase;

  Future<void> _onRequested(
    PokemonDetailRequested event,
    Emitter<PokemonDetailState> emit,
  ) async {
    emit(PokemonDetailLoading());
    final result = await searchPokemonUseCase(event.id);
    result.fold(
      (_) => emit(PokemonDetailError('No pudimos cargar el Pokémon')),
      (pokemon) => emit(PokemonDetailLoaded(pokemon: pokemon)),
    );
  }

  Future<void> _onCapture(
    PokemonDetailCaptureRequested event,
    Emitter<PokemonDetailState> emit,
  ) async {
    if (state is! PokemonDetailLoaded) return;
    final current = state as PokemonDetailLoaded;
    emit(current.copyWith(isCapturing: true, statusMessage: null));
    final result = await capturePokemonUseCase(current.pokemon);
    result.fold(
      (_) => emit(
        current.copyWith(
          isCapturing: false,
          statusMessage: 'No se pudo capturar',
          isStatusError: true,
        ),
      ),
      (_) => emit(
        current.copyWith(
          isCapturing: false,
          statusMessage: '¡Pokémon capturado!',
          isStatusError: false,
        ),
      ),
    );
  }
}
