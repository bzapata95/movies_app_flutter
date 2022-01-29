import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/helpers/debouncer.dart';
import 'package:movies/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseURL = 'api.themoviedb.org';
  final String _apiKEY = '37127f7dd60eb91f9d037d0e5efc59d9';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];

  final Map<int, List<Cast>> _moviesCast = {};

  int _popularPage = 0;
  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionStreamController =
      StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      _suggestionStreamController.stream;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData({required String pathURL, int? page = 1}) async {
    final url = Uri.https(_baseURL, pathURL,
        {'api_key': _apiKEY, 'language': _language, 'page': '$page'});

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData(pathURL: '/3/movie/now_playing');

    final newPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = newPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData =
        await _getJsonData(pathURL: '/3/movie/popular', page: _popularPage);

    final popularResponse = PopularResponse.fromJson(jsonData);

    onPopularMovies = [...onPopularMovies, ...popularResponse.results];

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    // Revisar el map
    if (_moviesCast.containsKey(movieId)) return _moviesCast[movieId]!;

    final jsonData = await _getJsonData(pathURL: '/3/movie/$movieId/credits');

    final castResponse = CreditsResponse.fromJson(jsonData);
    _moviesCast[movieId] = castResponse.cast;

    return castResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseURL, '3/search/movie',
        {'api_key': _apiKEY, 'language': _language, 'query': query});

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchMovie(value);
      _suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}
