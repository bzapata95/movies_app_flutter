import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseURL = 'api.themoviedb.org';
  final String _apiKEY = '37127f7dd60eb91f9d037d0e5efc59d9';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseURL, '/3/movie/now_playing',
        {'api_key': _apiKEY, 'language': _language, 'page': '1'});

    final response = await http.get(url);
    final newPlayingResponse = NowPlayingResponse.fromJson(response.body);

    onDisplayMovies = newPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(_baseURL, '/3/movie/popular',
        {'api_key': _apiKEY, 'language': _language, 'page': '1'});

    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);

    onPopularMovies = [...onPopularMovies, ...popularResponse.results];

    notifyListeners();
  }
}
