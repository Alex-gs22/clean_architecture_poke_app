# PokéApp — Clean Architecture Demo

A Flutter app built to showcase Clean Architecture in a simple, portfolio-friendly Pokémon experience. It consumes the public PokéAPI for search and details while persisting captured Pokémon locally. The data layer is fully replaceable: swap the API or storage without touching presentation or domain.

## Highlights
- Feature-first, layered design: presentation → domain → data
- BLoC for predictable state and UI reactivity
- Replaceable data sources (Dio remote, Hive local) behind repository abstractions
- Responsive UI for phones/tablets and orientation changes
- Light/dark themes driven by the system
- Shared navigation shell with persistent tab state and bottom navigation

## Architecture
- **Domain**: pure Dart (entities, repositories, use cases). No Flutter imports.
- **Data**: models plus remote/local data sources. Repository impl coordinates sources and exposes domain contracts.
- **Presentation**: widgets/pages only depend on use cases via BLoC. No data-layer imports.

## Tech Stack
- Flutter & Dart
- State: `flutter_bloc`
- HTTP: `dio`
- Local storage: `hive_flutter`
- DI: `get_it`

## Project Structure
```
lib/
├─ core/               # shared errors/utils
├─ features/
│  └─ pokemons/
│     ├─ domain/       # entities, repositories, use cases
│     ├─ data/         # models, remote/local data sources, repo impl
│     └─ presentation/ # pages, widgets, blocs
└─ shared/             # navigation shell, bottom nav, shared widgets
```

## Flows
- **Search**: enter ID (1–1025), view card, capture, open details.
- **Captured**: list stored Pokémon, view details, liberate.
- **Detail**: summary, types, base stats, capture/liberate with swipe-back.

## Getting Started
1. Install Flutter (3.x+ recommended).
2. Fetch dependencies: `flutter pub get`
3. Run: `flutter run`
4. Optional checks: `flutter analyze` and `flutter test`

## Extending / Swapping Data Sources
- To change the API: implement `PokemonsRemoteDataSource` and register it in `injection.dart`.
- To change local storage: implement `PokemonsLocalDataSource` (e.g., SQLite) and register it. The presentation/domain layers remain unchanged.

## License
MIT — free to use and adapt.
