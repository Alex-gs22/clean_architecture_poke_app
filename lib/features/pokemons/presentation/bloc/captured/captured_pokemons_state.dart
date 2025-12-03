part of 'captured_pokemons_bloc.dart';

sealed class CapturedPokemonsState {}

class CapturedPokemonsInitial extends CapturedPokemonsState {}

class CapturedPokemonsLoading extends CapturedPokemonsState {}

class CapturedPokemonsError extends CapturedPokemonsState {
  CapturedPokemonsError(this.message);
  final String message;
}

class CapturedPokemonsLoaded extends CapturedPokemonsState {
  CapturedPokemonsLoaded({
    required this.pokemons,
    this.isProcessingId,
    this.statusMessage,
    this.isStatusError = false,
  });

  final List<Pokemon> pokemons;
  final int? isProcessingId;
  final String? statusMessage;
  final bool isStatusError;

  CapturedPokemonsLoaded copyWith({
    List<Pokemon>? pokemons,
    int? isProcessingId,
    String? statusMessage,
    bool? isStatusError,
  }) {
    return CapturedPokemonsLoaded(
      pokemons: pokemons ?? this.pokemons,
      isProcessingId: isProcessingId,
      statusMessage: statusMessage,
      isStatusError: isStatusError ?? this.isStatusError,
    );
  }
}
