class Restaurant {
  const Restaurant(
      {required this.id,
      required this.name,
      required this.images,
      required this.branches});

  final String id;
  final String name;
  final List<String> images;
  final Map<int, String> branches;
}
