import 'package:clean_architecture_poke_app/core/errors/failures.dart';
import 'package:clean_architecture_poke_app/core/utils/utils.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/entities/pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/use_cases/capture_pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/use_cases/search_pokemon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_pokemon_event.dart';
part 'search_pokemon_state.dart';

class SearchPokemonBloc extends Bloc<SearchPokemonEvent, SearchPokemonState> {
  SearchPokemonBloc({
    required this.searchPokemonUseCase,
    required this.capturePokemonUseCase,
  }) : super(SearchPokemonInitial()) {
    on<SearchPokemonRequested>(_onSearchPokemonRequested);
    on<SearchPokemonRandomRequested>(_onSearchPokemonRandomRequested);
    on<SearchPokemonReset>(_onSearchPokemonReset);
    on<CapturePokemonRequested>(_onCapturePokemonRequested);
  }

  final SearchPokemonUseCase searchPokemonUseCase;
  final CapturePokemonUseCase capturePokemonUseCase;

  Future<void> _onSearchPokemonRequested(
    SearchPokemonRequested event,
    Emitter<SearchPokemonState> emit,
  ) async {
    if (event.id < 1 || event.id > 1025) {
      emit(SearchPokemonError('Ingresa un ID válido (1 - 1025)'));
      return;
    }
    emit(SearchPokemonLoading());
    final result = await searchPokemonUseCase(event.id);
    result.fold(
      (failure) => emit(SearchPokemonError('No pudimos encontrar el Pokémon')),
      (pokemon) => emit(SearchPokemonLoaded(pokemon: pokemon)),
    );
  }

  Future<void> _onSearchPokemonRandomRequested(
    SearchPokemonRandomRequested event,
    Emitter<SearchPokemonState> emit,
  ) async {
    add(SearchPokemonRequested(randomPokemonId));
  }

  void _onSearchPokemonReset(
    SearchPokemonReset event,
    Emitter<SearchPokemonState> emit,
  ) {
    emit(SearchPokemonInitial());
  }

  Future<void> _onCapturePokemonRequested(
    CapturePokemonRequested event,
    Emitter<SearchPokemonState> emit,
  ) async {
    if (state is! SearchPokemonLoaded) return;
    final current = state as SearchPokemonLoaded;
    emit(current.copyWith(isCapturing: true, statusMessage: null));
    final result = await capturePokemonUseCase(event.pokemon);
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
}
