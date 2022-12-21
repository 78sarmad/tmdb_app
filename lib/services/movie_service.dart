import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_app/helpers/rest_client.dart';
import 'package:tmdb_app/models/m_movie_details.dart';
import 'package:tmdb_app/models/m_upcoming_movies.dart';

final movieServiceProvider = Provider<MovieService>((ref) => MovieService());

class MovieService {
  RestClient restClient = RestClient();

  Future<UpcomingMovies> fetchUpcomingMovies() async {
    var responseContent = await restClient.getAsync('movie/upcoming');
    return UpcomingMovies.fromJson(responseContent);
  }

  Future<MovieDetails> fetchMovieDetails(int movieId) async {
    var responseContent = await restClient.getAsync('movie/$movieId');
    return MovieDetails.fromJson(responseContent);
  }
}
