import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:studio_ghibli_api/models/film.dart';
import 'package:studio_ghibli_api/screens/details_screen.dart';
import 'package:studio_ghibli_api/services/sg_api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Film>> _futureFilms;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _futureFilms = _apiService.fetchFilms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Studio Ghibli'), centerTitle: true),
      body: FutureBuilder<List<Film>>(
        future: _futureFilms,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final films = snapshot.data!;
            
            return ListView.builder(
              itemCount: films.length,
              itemBuilder: (context, index) {
                final film = films[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(film),
                        ),
                      );
                    },
                    leading: CachedNetworkImage(
                      imageUrl: film.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => const CircularProgressIndicator(),
                      errorWidget:
                          (context, url, error) => const Icon(Icons.error),
                    ),
                    title: Text(film.title),
                    subtitle: Text('Release date: ${film.release_date}'),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Nenhum dado disponível'));
        },
      ),
    );
  }
}
