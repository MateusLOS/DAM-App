import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'recommendation_model.dart';
import 'favorites_provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String selectedStatus = 'Todos';
  final TextEditingController _searchController = TextEditingController();
  MediaType _selectedTab = MediaType.film;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FavoritesProvider>();
    final favorites = provider.favorites
        .where((r) => r.type == _selectedTab)
        .where((r) => r.title.toLowerCase().contains(_searchController.text.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Row(
              children: [
                _buildTab(MediaType.film, 'Filmes'),
                _buildTab(MediaType.series, 'Séries'),
                _buildTab(MediaType.anime, 'Animes'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'pesquise pelo título ou elenco',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: selectedStatus,
                  items: const [
                    DropdownMenuItem(value: 'Todos', child: Text('Status')),
                    DropdownMenuItem(value: 'Assistido', child: Text('Assistido')),
                    DropdownMenuItem(value: 'Quero ver', child: Text('Quero ver')),
                  ],
                  onChanged: (v) => setState(() => selectedStatus = v ?? 'Todos'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: favorites.isEmpty
                ? const Center(child: Text('Nenhum item favoritado ainda.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: favorites.length,
                    itemBuilder: (_, i) => _FavoriteCard(r: favorites[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(MediaType type, String label) {
    final selected = _selectedTab == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = type),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? Colors.orange : Colors.grey[300],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.white : Colors.black,
                )),
          ),
        ),
      ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final Recommendation r;
  const _FavoriteCard({required this.r});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FavoritesProvider>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: r.imageUrl.isNotEmpty
                  ? Image.network(r.imageUrl, width: 80, height: 120, fit: BoxFit.cover)
                  : Container(width: 80, height: 120, color: Colors.grey[300]),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    r.description.isNotEmpty ? r.description : 'Sem descrição',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.thumb_up_alt_outlined),
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Você curtiu ${r.title}')),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${r.title} já está nos favoritos')),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_red_eye_outlined),
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${r.title} marcado como "Quero ver"')),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => provider.toggleFavorite(r),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
