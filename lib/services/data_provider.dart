import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_app/models/m_movie_details.dart';
import 'package:tmdb_app/models/m_upcoming_movies.dart';
import 'package:tmdb_app/services/movie_service.dart';

class DataProvider {
  static final upcomingMoviesProvider = FutureProvider<UpcomingMovies>((ref) {
    return ref.read(movieServiceProvider).fetchUpcomingMovies();
  });

  static final movieDetailsProvider = FutureProvider.autoDispose
      .family<MovieDetails, int>((ref, movieId) async {
    return ref.read(movieServiceProvider).fetchMovieDetails(movieId);
  });
}
