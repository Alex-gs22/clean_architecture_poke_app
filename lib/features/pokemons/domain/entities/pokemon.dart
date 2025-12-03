class Pokemon {
  final int id;
  final String name;
  final String image;
  final int height;
  final int weight;
  final int baseExperience;
  final List<String> types;
  final Map<String, int> stats;

  Pokemon({
    required this.id,
    required this.name,
    required this.image,
    required this.weight,
    required this.height,
    required this.baseExperience,
    required this.types,
    required this.stats,
  });
}
