import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movies/providers/providers.dart';
import 'package:movies/search/search_movie_delegate.dart';
import 'package:movies/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: const Text('Peliculas en cines'),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => showSearch(
                    context: context, delegate: MovieSearchDelegate()),
                icon: const Icon(Icons.search))
          ]),
      body: SingleChildScrollView(
          child: Column(children: [
        CardSwiper(movies: moviesProvider.onDisplayMovies),
        MovieSlider(
          movies: moviesProvider.onPopularMovies,
          title: 'Populares',
          onNextPage: () => moviesProvider.getPopularMovies(),
        ),
      ])),
    );
  }
}
