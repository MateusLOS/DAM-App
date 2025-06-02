import 'dart:convert';
import 'package:http/http.dart' as http;
import 'recommendation_model.dart';

class TMDbSearchService {
  static const String _apiKey = '090f4b479cc5231142ba19615a21dd73'; 
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  static Future<List<Recommendation>> search({
    required String query,
    required MediaType type,
  }) async {
    final endpoint = type == MediaType.film ? 'movie' : 'tv';
    final url = '$_baseUrl/search/$endpoint?api_key=$_apiKey&language=pt-BR&query=${Uri.encodeQueryComponent(query)}';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;

      return results.map((item) {
        return Recommendation(
          id: item['id'].toString(),
          title: item['title'] ?? item['name'] ?? 'Sem título',
          description: item['overview'] ?? '',
          imageUrl: item['poster_path'] != null
              ? 'https://image.tmdb.org/t/p/w500${item['poster_path']}'
              : '',
          type: type,
        );
      }).toList();
    } else {
      throw Exception('Erro ao buscar dados do TMDb (search)');
    }
  }

  static Future<List<Recommendation>> fetchByGenre({
    required String genre,
    required MediaType type,
  }) async {
    final genreMap = {
      'Ação': 28,
      'Comédia': 35,
      'Drama': 18,
      'Terror': 27,
      'Romance': 10749,
      'Ficção': 878,
      'Fantasia': 14,
    };

    final genreId = genreMap[genre];
    if (genreId == null) return [];

    final endpoint = type == MediaType.film ? 'movie' : 'tv';
    final url = '$_baseUrl/discover/$endpoint?api_key=$_apiKey&language=pt-BR&with_genres=$genreId';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;

      return results.map((item) {
        return Recommendation(
          id: item['id'].toString(),
          title: item['title'] ?? item['name'] ?? 'Sem título',
          description: item['overview'] ?? '',
          imageUrl: item['poster_path'] != null
              ? 'https://image.tmdb.org/t/p/w500${item['poster_path']}'
              : '',
          type: type,
        );
      }).toList();
    } else {
      return [];
    }
  }
}
