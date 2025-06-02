import 'package:flutter/material.dart';
import 'recommendation_model.dart';

class RatingsPage extends StatelessWidget {
  final Recommendation recommendation;
  final List<Map<String, dynamic>> ratings;

  const RatingsPage({
    super.key,
    required this.recommendation,
    required this.ratings,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Avaliações')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ratings.isEmpty
            ? const Center(child: Text('Nenhuma avaliação realizada.'))
            : ListView.builder(
                itemCount: ratings.length,
                itemBuilder: (_, i) {
                  final rating = ratings[i];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Row(
                        children: List.generate(
                          rating['rating'],
                          (_) => const Icon(Icons.star, size: 20, color: Colors.orange),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (rating['comment'].toString().isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(rating['comment']),
                            ),
                          const SizedBox(height: 4),
                          Text(
                            _formatDate(rating['timestamp']),
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Pesquisar'),
          BottomNavigationBarItem(icon: Icon(Icons.star_border), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configurações'),
        ],
      ),
    );
  }

  String _formatDate(String isoDate) {
    try {
      final dt = DateTime.parse(isoDate);
      return '${dt.day}/${dt.month}/${dt.year} às ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return '';
    }
  }
}
