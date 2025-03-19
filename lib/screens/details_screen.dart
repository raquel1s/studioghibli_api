import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:studio_ghibli_api/models/character.dart';
import 'package:studio_ghibli_api/models/film.dart';
import 'package:studio_ghibli_api/services/sg_api_service.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(this.film, {super.key});
  final Film film;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<List<Character>> _futureCharacters;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _futureCharacters = _apiService.fetchCharacter();
  }

  @override
  Widget build(BuildContext context) {
    final film = widget.film;

    return Scaffold(
      appBar: AppBar(
        title: Text(film.title, style: TextStyle(fontSize: 28)),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Character>>(
        future: _futureCharacters,
        builder: (context, charSnapshot) {
          if (charSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (charSnapshot.hasError) {
            return Center(child: Text('Erro: ${charSnapshot.error}'));
          } else if (charSnapshot.hasData) {
            final characters = charSnapshot.data!;

            final filmCharacters = characters.where((character) {
              final characterId = character.id; 
              return film.characters.any((characterUrl) => characterUrl.endsWith(characterId));
            }).toList();

            return Center(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Text(
                          film.original_title,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 25),
                        CachedNetworkImage(
                          imageUrl: film.movie_banner,
                          width: 400,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            film.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Release Date: ${film.release_date}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Running Time: ${film.running_time}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Characters:',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        for (var character in filmCharacters)
                        ListTile(
                          title: Text(character.name),
                          subtitle: Text(character.gender),
                          trailing: Text(character.age)
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Nenhum dado disponível'));
        },
      ),
    );
  }
}
