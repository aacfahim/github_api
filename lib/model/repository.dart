class Repository {
  final String name;
  final String description;
  final int stargazersCount;
  final int forksCount;

  Repository({
    required this.name,
    required this.description,
    required this.stargazersCount,
    required this.forksCount,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      stargazersCount: json['stargazers_count'] as int,
      forksCount: json['forks_count'] as int,
    );
  }
}
