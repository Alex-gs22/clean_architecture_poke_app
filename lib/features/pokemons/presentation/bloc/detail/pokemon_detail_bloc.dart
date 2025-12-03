import 'package:clean_architecture_poke_app/core/errors/failures.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/entities/pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/use_cases/capture_pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/use_cases/liberate_pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/use_cases/search_pokemon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pokemon_detail_event.dart';
part 'pokemon_detail_state.dart';

class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  PokemonDetailBloc({
    required this.searchPokemonUseCase,
    required this.capturePokemonUseCase,
    required this.liberatePokemonUseCase,
  }) : super(PokemonDetailInitial()) {
    on<PokemonDetailRequested>(_onRequested);
    on<PokemonDetailCaptureRequested>(_onCapture);
    on<PokemonDetailLiberateRequested>(_onLiberate);
  }

  final SearchPokemonUseCase searchPokemonUseCase;
  final CapturePokemonUseCase capturePokemonUseCase;
  final LiberatePokemonUseCase liberatePokemonUseCase;

  Future<void> _onRequested(
    PokemonDetailRequested event,
    Emitter<PokemonDetailState> emit,
  ) async {
    emit(PokemonDetailLoading());
    final result = await searchPokemonUseCase(event.id);
    result.fold(
      (_) => emit(PokemonDetailError('No pudimos cargar el Pokémon')),
      (pokemon) => emit(
        PokemonDetailLoaded(
          pokemon: pokemon,
          isCaptured: event.isCaptured,
        ),
      ),
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
      (failure) {
        if (failure is AlreadyCapturedFailure) {
          emit(
            current.copyWith(
              isCaptured: true,
              isCapturing: false,
              statusMessage: 'Ya está capturado',
              isStatusError: true,
            ),
          );
        } else {
          emit(
            current.copyWith(
              isCapturing: false,
              statusMessage: 'No se pudo capturar',
              isStatusError: true,
            ),
          );
        }
      },
      (_) => emit(
        current.copyWith(
          isCaptured: true,
          isCapturing: false,
          statusMessage: '¡Pokémon capturado!',
          isStatusError: false,
        ),
      ),
    );
  }

  Future<void> _onLiberate(
    PokemonDetailLiberateRequested event,
    Emitter<PokemonDetailState> emit,
  ) async {
    if (state is! PokemonDetailLoaded) return;
    final current = state as PokemonDetailLoaded;
    emit(current.copyWith(isProcessing: true, statusMessage: null));
    final result = await liberatePokemonUseCase(current.pokemon.id);
    result.fold(
      (_) => emit(
        current.copyWith(
          isProcessing: false,
          statusMessage: 'No se pudo liberar',
          isStatusError: true,
        ),
      ),
      (_) => emit(
        current.copyWith(
          isCaptured: false,
          isProcessing: false,
          statusMessage: 'Pokémon liberado',
          isStatusError: false,
        ),
      ),
    );
  }
}
