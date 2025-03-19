import 'dart:convert';
import 'package:studio_ghibli_api/models/character.dart';
import 'package:studio_ghibli_api/models/film.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://ghibliapi.vercel.app';

  Future<List<Film>> fetchFilms() async {
    final response = await http.get(Uri.parse('$baseUrl/films'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Film.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar os filmes');
    }
  }

  Future<List<Character>> fetchCharacter() async {
    final response = await http.get(Uri.parse('$baseUrl/people'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar os filmes');
    }
  }

}