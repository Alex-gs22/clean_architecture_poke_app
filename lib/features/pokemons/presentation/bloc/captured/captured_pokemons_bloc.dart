import 'package:clean_architecture_poke_app/features/pokemons/domain/entities/pokemon.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/use_cases/get_captured_pokemons.dart';
import 'package:clean_architecture_poke_app/features/pokemons/domain/use_cases/liberate_pokemon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'captured_pokemons_event.dart';
part 'captured_pokemons_state.dart';

class CapturedPokemonsBloc
    extends Bloc<CapturedPokemonsEvent, CapturedPokemonsState> {
  CapturedPokemonsBloc({
    required this.getCapturedPokemonsUseCase,
    required this.liberatePokemonUseCase,
  }) : super(CapturedPokemonsInitial()) {
    on<CapturedPokemonsRequested>(_onRequested);
    on<LiberatePokemonRequested>(_onLiberate);
  }

  final GetCapturedPokemonsUseCase getCapturedPokemonsUseCase;
  final LiberatePokemonUseCase liberatePokemonUseCase;

  Future<void> _onRequested(
    CapturedPokemonsRequested event,
    Emitter<CapturedPokemonsState> emit,
  ) async {
    emit(CapturedPokemonsLoading());
    final result = await getCapturedPokemonsUseCase();
    result.fold(
      (_) => emit(CapturedPokemonsError('No pudimos cargar tus Pokémon')),
      (pokemons) => emit(CapturedPokemonsLoaded(pokemons: pokemons)),
    );
  }

  Future<void> _onLiberate(
    LiberatePokemonRequested event,
    Emitter<CapturedPokemonsState> emit,
  ) async {
    if (state is! CapturedPokemonsLoaded) return;
    final current = state as CapturedPokemonsLoaded;
    emit(current.copyWith(isProcessingId: event.id));
    final result = await liberatePokemonUseCase(event.id);
    result.fold(
      (_) => emit(
        current.copyWith(
          isProcessingId: null,
          statusMessage: 'No se pudo liberar',
          isStatusError: true,
        ),
      ),
      (_) {
        final updated =
            current.pokemons.where((p) => p.id != event.id).toList();
        emit(
          current.copyWith(
            pokemons: updated,
            isProcessingId: null,
            statusMessage: 'Pokémon liberado',
            isStatusError: false,
          ),
        );
      },
    );
  }
}
