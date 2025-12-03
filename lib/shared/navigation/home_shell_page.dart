import 'package:clean_architecture_poke_app/features/pokemons/presentation/bloc/captured/captured_pokemons_bloc.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/bloc/search/search_pokemon_bloc.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/pages/captured_pokemons_page.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/pages/search_pokemon_page.dart';
import 'package:clean_architecture_poke_app/shared/navigation/home_shell_scope.dart';
import 'package:clean_architecture_poke_app/shared/widgets/app_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeShellPage extends StatefulWidget {
  const HomeShellPage({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<HomeShellPage> createState() => _HomeShellPageState();
}

class _HomeShellPageState extends State<HomeShellPage> {
  late final ValueNotifier<int> _tabNotifier;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _tabNotifier = ValueNotifier<int>(_index);
  }

  @override
  void dispose() {
    _tabNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const SearchPokemonPage(),
      const CapturedPokemonsPage(),
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<SearchPokemonBloc>()),
        BlocProvider.value(value: context.read<CapturedPokemonsBloc>()),
      ],
      child: HomeShellScope(
        tabNotifier: _tabNotifier,
        setTab: (i) {
          if (_index == i) return;
          setState(() {
            _index = i;
            _tabNotifier.value = i;
          });
          if (i == 1) {
            context
                .read<CapturedPokemonsBloc>()
                .add(CapturedPokemonsRequested());
          }
        },
        child: Scaffold(
          body: IndexedStack(
            index: _index,
            children: pages,
          ),
          bottomNavigationBar: ValueListenableBuilder<int>(
            valueListenable: _tabNotifier,
            builder: (context, value, _) {
              return AppBottomNav(
                currentIndex: value,
                onTap: (i) => HomeShellScope.of(context)?.setTab(i),
              );
            },
          ),
        ),
      ),
    );
  }
}
