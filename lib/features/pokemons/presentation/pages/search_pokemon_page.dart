import 'package:clean_architecture_poke_app/core/utils/utils.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/bloc/search/search_pokemon_bloc.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/widgets/search_header.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/widgets/search_input_card.dart';
import 'package:clean_architecture_poke_app/features/pokemons/presentation/widgets/search_result_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPokemonPage extends StatefulWidget {
  const SearchPokemonPage({super.key});

  @override
  State<SearchPokemonPage> createState() => _SearchPokemonPageState();
}

class _SearchPokemonPageState extends State<SearchPokemonPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final background = Theme.of(context).colorScheme.background;
    return ColoredBox(
      color: background,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidth =
                constraints.maxWidth > 520 ? 480 : constraints.maxWidth;
            final double horizontal = constraints.maxWidth > 520
                ? (constraints.maxWidth - maxWidth) / 2
                : 20;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontal,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchHeader(),
                  const SizedBox(height: 20),
                  SearchInputCard(
                    controller: _controller,
                    onSearch: () => _onSearch(context),
                    onRandom: () => _onRandom(context),
                  ),
                  const SizedBox(height: 32),
                  const SearchResultArea(),
                ],
              ),
            );
         },
       ),
     ),
   );
 }

  void _onSearch(BuildContext context) {
    final raw = _controller.text.trim();
    if (raw.isEmpty) {
      context.read<SearchPokemonBloc>().add(SearchPokemonReset());
      return;
    }
    final id = int.tryParse(raw);
    if (id == null) {
      context.read<SearchPokemonBloc>().add(SearchPokemonReset());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Ingresa un ID válido')));
      return;
    }
    context.read<SearchPokemonBloc>().add(SearchPokemonRequested(id));
  }

  void _onRandom(BuildContext context) {
    _controller.text = randomPokemonId.toString();
    context.read<SearchPokemonBloc>().add(SearchPokemonRandomRequested());
  }
}
