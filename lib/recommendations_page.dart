import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'recommendation_model.dart';
import 'tmdb_service.dart';
import 'favorites_provider.dart';
import 'favorites_page.dart';
import 'genreselectionpage.dart';
import 'searchpage.dart';
import 'settings_page.dart';
import 'details_page.dart';

class RecommendationsPage extends StatefulWidget {
  final Set<String> selectedGenres;
  const RecommendationsPage({super.key, required this.selectedGenres});

  @override
  State<RecommendationsPage> createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage> {
  final Map<MediaType, Future<List<Recommendation>>> _futureMap = {};

  @override
  void initState() {
    super.initState();
    for (final type in MediaType.values) {
      _futureMap[type] =
          TmdbService.fetchRecommendations(type, widget.selectedGenres);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Recomendações'),
          bottom: TabBar(
            tabs: MediaType.values.map((e) => Tab(text: e.label)).toList(),
          ),
        ),
        body: TabBarView(
          children: MediaType.values.map((type) {
            return FutureBuilder<List<Recommendation>>(
              future: _futureMap[type],
              builder: (_, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                }

                final results = snapshot.data ?? [];
                if (results.isEmpty) {
                  return const Center(child: Text('Nada encontrado'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: results.length,
                  itemBuilder: (_, i) => _RecommendationCard(r: results[i]),
                );
              },
            );
          }).toList(),
        ),
        bottomNavigationBar: _BottomNavBar(),
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  final Recommendation r;
  const _RecommendationCard({required this.r});

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<FavoritesProvider>().isFavorite(r);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailsPage(recommendation: r)),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: r.imageUrl.isNotEmpty
                        ? Image.network(
                            r.imageUrl,
                            width: 80,
                            height: 120,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 80,
                            height: 120,
                            color: Colors.grey[300],
                          ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          r.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          r.description.isNotEmpty
                              ? r.description
                              : 'Sem descrição',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: isFavorite ? Colors.orange : Colors.grey,
                  ),
                  tooltip: isFavorite
                      ? 'Remover dos favoritos'
                      : 'Adicionar aos favoritos',
                  onPressed: () {
                    context.read<FavoritesProvider>().toggleFavorite(r);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0, // Nenhuma aba selecionada
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
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SearchPage()),
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
        BottomNavigationBarItem(
            icon: Icon(Icons.star_border), label: 'Favoritos'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), label: 'Configurações'),
      ],
    );
  }
}
