import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'recommendation_model.dart';
import 'ratings_page.dart';
import 'settings_page.dart';

class DetailsPage extends StatefulWidget {
  final Recommendation recommendation;
  const DetailsPage({super.key, required this.recommendation});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int selectedRating = 0;
  bool isCommenting = false;
  final TextEditingController _commentController = TextEditingController();
  final List<Map<String, dynamic>> ratings = [];

  Future<void> _openTrailer() async {
    final query = Uri.encodeComponent('${widget.recommendation.title} trailer');
    final url = Uri.parse('https://www.youtube.com/results?search_query=$query');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.platformDefault);
    } else {
      _showError('Não foi possível abrir o trailer.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _saveRating() {
    final comment = _commentController.text.trim();
    if (selectedRating > 0 || comment.isNotEmpty) {
      setState(() {
        ratings.add({
          'rating': selectedRating,
          'comment': comment,
          'timestamp': DateTime.now().toIso8601String(),
        });
        _commentController.clear();
        selectedRating = 0;
        isCommenting = false;
      });
    }
  }

  void _deleteRating(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Deseja realmente excluir esta avaliação?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                ratings.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Sim'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.recommendation;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Filme')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: r.imageUrl.isNotEmpty
                  ? Image.network(r.imageUrl, height: 200, fit: BoxFit.cover)
                  : Container(height: 200, color: Colors.grey[300]),
            ),
            const SizedBox(height: 16),
            Text(r.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Lançamento: -'),
            const Text('Gênero: -'),
            const SizedBox(height: 12),

            const Text('Avaliação:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) {
                return IconButton(
                  icon: Icon(
                    i < selectedRating ? Icons.star : Icons.star_border,
                    color: Colors.orange,
                  ),
                  onPressed: () => setState(() => selectedRating = i + 1),
                );
              }),
            ),

            const SizedBox(height: 12),
            Text(
              r.description.isNotEmpty ? r.description : 'Sem descrição.',
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _openTrailer,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Ver trailer', style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 12),

            if (!isCommenting)
              ElevatedButton(
                onPressed: () => setState(() => isCommenting = true),
                child: const Text('Escrever comentário'),
              ),
            if (isCommenting)
              Column(
                children: [
                  TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Escreva seu comentário...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _saveRating,
                        child: const Text('Salvar'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () => setState(() => isCommenting = false),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                        child: const Text('Cancelar'),
                      ),
                    ],
                  ),
                ],
              ),

            const SizedBox(height: 20),

            if (ratings.isNotEmpty) ...[
              const Divider(),
              const Text('Minhas Avaliações', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              for (int i = 0; i < ratings.length; i++)
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    title: Row(
                      children: List.generate(
                        ratings[i]['rating'],
                        (_) => const Icon(Icons.star, size: 20, color: Colors.orange),
                      ),
                    ),
                    subtitle: Text(ratings[i]['comment']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _deleteRating(i),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RatingsPage(
                        ratings: ratings,
                        recommendation: r,
                      ),
                    ),
                  );
                },
                child: const Text('Ver todas minhas avaliações'),
              ),
            ],
          ],
        ),
      ),
  bottomNavigationBar: BottomNavigationBar(
  currentIndex: 2, // índice da aba atual (Favoritos)
  selectedItemColor: Colors.orange,
  unselectedItemColor: Colors.black,
  type: BottomNavigationBarType.fixed,
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Pesquisar'),
    BottomNavigationBarItem(icon: Icon(Icons.star_border), label: 'Favoritos'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configurações'),
  ],
  onTap: (index) {
    if (index == 0) {
      Navigator.popUntil(context, (route) => route.isFirst);
    } else if (index == 1) {
      // Navega para a aba de pesquisar, se tiver
    } else if (index == 2) {
      // Já está na aba de detalhes de favoritos
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SettingsPage()),
      );
    }
  },
),
    );
  }
}