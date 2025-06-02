import 'dart:convert';
import 'package:http/http.dart' as http;
import 'recommendation_model.dart';

class TmdbService {
  static const String _token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwOTBmNGI0NzljYzUyMzExNDJiYTE5NjE1YTIxZGQ3MyIsIm5iZiI6MTczMTY5NjE1Ni45MzIsInN1YiI6IjY3Mzc5NjFjMjk1NGQyNjQ3NjI1YzBmYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.37cHbYOw4zZ40tJMbUaqaBoUW-EK3OZXYrdn29z0NPs';

  static const String _baseUrl = 'https://api.themoviedb.org/3';

  static const Map<String, int> _genreMap = {
    'Ação': 28,
    'Aventura': 12,
    'Comédia': 35,
    'Drama': 18,
    'Fantasia': 14,
    'Ficção Científica': 878,
    'Suspense': 53,
    'Terror': 27,
    'Mistério': 9648,
    'Romance': 10749,
    'Slice of Life': 99,
    'Cyberpunk': 878,
  };

  /// Busca recomendações com base no tipo e gêneros
  static Future<List<Recommendation>> fetchRecommendations(
    MediaType type,
    Set<String> genres,
  ) async {
    final genreIds = genres.map((g) => _genreMap[g]).whereType<int>().join(',');
    final headers = {
      'Authorization': 'Bearer $_token',
      'Content-Type': 'application/json',
    };

    late Uri url;

    if (type == MediaType.anime) {
      url = Uri.parse('$_baseUrl/search/tv?query=anime&language=pt-BR&page=1');
    } else if (type == MediaType.series) {
      url = Uri.parse(
        '$_baseUrl/discover/tv?language=pt-BR&sort_by=popularity.desc${genreIds.isNotEmpty ? '&with_genres=$genreIds' : ''}',
      );
    } else {
      url = Uri.parse(
        '$_baseUrl/discover/movie?language=pt-BR&sort_by=popularity.desc${genreIds.isNotEmpty ? '&with_genres=$genreIds' : ''}',
      );
    }

    final response = await http.get(url, headers: headers);

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar dados TMDB (${response.statusCode})');
    }

    final List results = json.decode(response.body)['results'];

    return results.map((r) {
      final title = r['title'] ?? r['name'] ?? 'Sem título';
      return Recommendation(
        id: r['id'].toString(),
        title: title,
        description: r['overview'] ?? '',
        imageUrl: r['poster_path'] != null
            ? 'https://image.tmdb.org/t/p/w300${r['poster_path']}'
            : '',
        type: type,
      );
    }).toList();
  }

  /// Busca o trailer exato de um filme ou série
  static Future<String?> fetchTrailerUrl(String id, MediaType type) async {
    final path = type == MediaType.film ? 'movie' : 'tv';
    final url = Uri.parse('$_baseUrl/$path/$id/videos?language=pt-BR');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
      'Content-Type': 'application/json',
    });

    if (response.statusCode != 200) return null;

    final data = json.decode(response.body);
    final results = data['results'] as List;

    final trailer = results.firstWhere(
      (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
      orElse: () => null,
    );

    if (trailer != null && trailer['key'] != null) {
      return 'https://www.youtube.com/watch?v=${trailer['key']}';
    }

    return null;
  }
}