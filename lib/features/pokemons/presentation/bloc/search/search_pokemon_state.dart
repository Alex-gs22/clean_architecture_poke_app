part of 'search_pokemon_bloc.dart';

sealed class SearchPokemonState {}

class SearchPokemonInitial extends SearchPokemonState {}

class SearchPokemonLoading extends SearchPokemonState {}

class SearchPokemonError extends SearchPokemonState {
  SearchPokemonError(this.message);
  final String message;
}

class SearchPokemonLoaded extends SearchPokemonState {
  SearchPokemonLoaded({
    required this.pokemon,
    this.isCapturing = false,
    this.statusMessage,
    this.isStatusError = false,
  });

  final Pokemon pokemon;
  final bool isCapturing;
  final String? statusMessage;
  final bool isStatusError;

  SearchPokemonLoaded copyWith({
    Pokemon? pokemon,
    bool? isCapturing,
    String? statusMessage,
    bool? isStatusError,
  }) {
    return SearchPokemonLoaded(
      pokemon: pokemon ?? this.pokemon,
      isCapturing: isCapturing ?? this.isCapturing,
      statusMessage: statusMessage,
      isStatusError: isStatusError ?? this.isStatusError,
    );
  }
}
