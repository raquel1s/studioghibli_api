import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:studio_ghibli_api/models/film.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(this.film, {super.key});
  final Film film;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final film = widget.film;

    return Scaffold(
      appBar: AppBar(
        title: Text(film.title, style: TextStyle(fontSize: 28)),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
