import 'dart:math';
import 'package:flutter/material.dart';
import 'recommendations_page.dart';
import 'favorites_page.dart';
import 'settings_page.dart';
import 'searchpage.dart'; // <-- Importando a nova página de pesquisa

class GenreSelectionPage extends StatefulWidget {
  const GenreSelectionPage({super.key});

  @override
  State<GenreSelectionPage> createState() => _GenreSelectionPageState();
}

class _GenreSelectionPageState extends State<GenreSelectionPage> {
  final List<String> genres = [
    'Ação', 'Aventura', 'Comédia', 'Drama', 'Fantasia',
    'Ficção Científica', 'Suspense', 'Terror', 'Mistério',
    'Romance', 'Slice of Life', 'Cyberpunk'
  ];

  final Set<String> selectedGenres = {};
  late final Map<String, Color> genreColors;

  @override
  void initState() {
    super.initState();
    final rand = Random();
    genreColors = {
      for (final g in genres)
        g: Colors.primaries[rand.nextInt(Colors.primaries.length)].withOpacity(0.7)
    };
  }

  void _goToRecommendations() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecommendationsPage(selectedGenres: selectedGenres),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SearchPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FavoritesPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SettingsPage()),
        );
        break;
      case 0:
      default:
        // Já estamos na página inicial
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha seus gêneros favoritos'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: genres.length,
              itemBuilder: (_, i) {
                final g = genres[i];
                return GestureDetector(
                  onTap: () => setState(() {
                    selectedGenres.contains(g)
                        ? selectedGenres.remove(g)
                        : selectedGenres.add(g);
                  }),
                  child: Card(
                    elevation: selectedGenres.contains(g) ? 6 : 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: genreColors[g],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: selectedGenres.contains(g)
                              ? Colors.orange
                              : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          g,
                          style: TextStyle(
                            color: genreColors[g]!.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 70,
            right: 16,
            child: FloatingActionButton(
              onPressed: _goToRecommendations,
              tooltip: 'Avançar',
              child: const Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Pesquisar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}
