import 'dart:async';
import 'package:flutter/material.dart';
import 'favorites_page.dart';
import 'genreselectionpage.dart';
import 'settings_page.dart';
import 'recommendation_model.dart';
import 'tmdb_search_service.dart';
import 'details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  MediaType _selectedType = MediaType.film;
  final List<String> genres = [
    'Ação', 'Comédia', 'Drama', 'Terror', 'Romance', 'Ficção', 'Fantasia'
  ];

  final Map<String, List<Recommendation>> _genreRecommendations = {};
  List<Recommendation> _searchResults = [];

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _fetchAllGenres();

    _searchController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 400), () {
        if (_searchController.text.isNotEmpty) {
          _performSearch(_searchController.text);
        } else {
          setState(() => _searchResults.clear());
        }
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    final results = await TMDbSearchService.search(
      query: query,
      type: _selectedType,
    );
    setState(() => _searchResults = results);
  }

  Future<void> _fetchAllGenres() async {
    for (final genre in genres) {
      final recs = await TMDbSearchService.fetchByGenre(
        genre: genre,
        type: _selectedType,
      );
      setState(() {
        _genreRecommendations[genre] = recs;
      });
    }
  }

  Widget _buildCarousel(String genre, List<Recommendation> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(genre, style: Theme.of(context).textTheme.titleLarge),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsPage(recommendation: item),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.imageUrl,
                      width: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _searchResults.map((item) {
        return ListTile(
          leading: item.imageUrl.isNotEmpty
              ? Image.network(item.imageUrl, width: 50, fit: BoxFit.cover)
              : const Icon(Icons.broken_image),
          title: Text(item.title),
          subtitle: Text(item.description, maxLines: 2, overflow: TextOverflow.ellipsis),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailsPage(recommendation: item),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesquisar')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar por título ou elenco',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: MediaType.values.map((type) {
                  final isSelected = _selectedType == type;
                  return ChoiceChip(
                    label: Text(
                      type == MediaType.film
                          ? 'Filmes'
                          : type == MediaType.series
                              ? 'Séries'
                              : 'Animes',
                    ),
                    selected: isSelected,
                    selectedColor: Colors.orange,
                    onSelected: (_) {
                      setState(() => _selectedType = type);
                      _fetchAllGenres();
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              if (_searchResults.isNotEmpty)
                _buildSearchResults()
              else
                ...genres.map((g) {
                  final list = _genreRecommendations[g] ?? [];
                  return list.isEmpty ? const SizedBox.shrink() : _buildCarousel(g, list);
                }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const GenreSelectionPage()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesPage()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Pesquisar'),
          BottomNavigationBarItem(icon: Icon(Icons.star_border), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configurações'),
        ],
      ),
    );
  }
}
