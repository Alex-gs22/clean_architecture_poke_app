import 'package:clean_architecture_poke_app/injection.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/bloc/search/search_pokemon_bloc.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/bloc/detail/pokemon_detail_bloc.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/bloc/captured/captured_pokemons_bloc.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/pages/pokemon_detail_page.dart';
import 'package:clean_architecture_poke_app/shared/navigation/home_shell_page.dart';
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
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.light,
          background: const Color(0xFFF6F7FB),
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.dark,
          background: const Color(0xFF0F172A),
          surface: const Color(0xFF111827),
        ),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        useMaterial3: false,
      ),
      routes: {
        '/': (context) {
          final Object? rawArgs = ModalRoute.of(context)?.settings.arguments;
          int initialTab = 0;
          if (rawArgs is Map && rawArgs['tab'] == 1) {
            initialTab = 1;
          }
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => SearchPokemonBloc(
                  searchPokemonUseCase: getIt(),
                  capturePokemonUseCase: getIt(),
                  getCapturedPokemonsUseCase: getIt(),
                ),
              ),
              BlocProvider(
                create: (_) => CapturedPokemonsBloc(
                  getCapturedPokemonsUseCase: getIt(),
                  liberatePokemonUseCase: getIt(),
                )..add(CapturedPokemonsRequested()),
              ),
            ],
            child: HomeShellPage(initialIndex: initialTab),
          );
        },
        '/pokemon_detail': (context) {
          final Object? rawArgs = ModalRoute.of(context)?.settings.arguments;
          Map args = {};
          if (rawArgs is Map) {
            args = rawArgs;
          }
          final int id = (args['id'] ?? 0) as int;
          final bool isCaptured = args['captured'] == true;
          return BlocProvider(
            create: (_) => PokemonDetailBloc(
              searchPokemonUseCase: getIt(),
              capturePokemonUseCase: getIt(),
              liberatePokemonUseCase: getIt(),
            )..add(PokemonDetailRequested(id, isCaptured: isCaptured)),
            child: PokemonDetailPage(
              pokemonId: id,
              initialTab: isCaptured ? 1 : 0,
            ),
          );
        },
      },
      initialRoute: '/',
    );
  }
}
