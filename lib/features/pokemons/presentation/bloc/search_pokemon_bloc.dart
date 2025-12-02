import 'package:clean_architecture_poke_app/core/utils/utils.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/entities/pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/use_cases/search_pokemon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_pokemon_event.dart';
part 'search_pokemon_state.dart';

class SearchPokemonBloc extends Bloc<SearchPokemonEvent, SearchPokemonState> {
  SearchPokemonBloc({required this.searchPokemonUseCase})
      : super(SearchPokemonInitial()) {
    on<SearchPokemonRequested>(_onSearchPokemonRequested);
    on<SearchPokemonRandomRequested>(_onSearchPokemonRandomRequested);
    on<SearchPokemonReset>(_onSearchPokemonReset);
  }

  final SearchPokemonUseCase searchPokemonUseCase;

  Future<void> _onSearchPokemonRequested(
    SearchPokemonRequested event,
    Emitter<SearchPokemonState> emit,
  ) async {
    if (event.id <= 0) {
      emit(SearchPokemonError('Ingresa un ID válido'));
      return;
    }
    emit(SearchPokemonLoading());
    final result = await searchPokemonUseCase(event.id);
    result.fold(
      (failure) => emit(SearchPokemonError('No pudimos encontrar el Pokémon')),
      (pokemon) => emit(SearchPokemonSuccess(pokemon)),
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
}
