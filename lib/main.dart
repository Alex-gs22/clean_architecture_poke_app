import 'package:clean_architecture_poke_app/injection.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/bloc/search_pokemon_bloc.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/pages/search_pokemon_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const PokeApp());
}

class PokeApp extends StatelessWidget {
  const PokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFF3B4CCA);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PokéApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        useMaterial3: false,
      ),
      home: BlocProvider(
        create: (_) => SearchPokemonBloc(searchPokemonUseCase: getIt()),
        child: const SearchPokemonPage(),
      ),
    );
  }
}
