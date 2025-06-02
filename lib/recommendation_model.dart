enum MediaType { film, series, anime }

class Recommendation {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final MediaType type;
  int rating;

  Recommendation({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.type,
    this.rating = 0,
  });

  // Serialização para salvar localmente
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'type': type.name, // usa o nome da enum como string
        'rating': rating,
      };

  // Desserialização para restaurar do cache
  static Recommendation fromJson(Map<String, dynamic> json) => Recommendation(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        type: MediaType.values.firstWhere((e) => e.name == json['type']),
        rating: json['rating'] ?? 0,
      );
}

extension MediaTypeLabel on MediaType {
  String get label {
    switch (this) {
      case MediaType.film:
        return 'Filmes';
      case MediaType.series:
        return 'Séries';
      case MediaType.anime:
        return 'Animes';
    }
  }

  String get tmdbType {
    switch (this) {
      case MediaType.film:
        return 'movie';
      case MediaType.series:
      case MediaType.anime:
        return 'tv';
    }
  }
}
