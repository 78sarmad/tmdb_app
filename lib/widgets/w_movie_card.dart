import 'package:flutter/material.dart';
import 'package:tmdb_app/helpers/colors.dart';
import 'package:tmdb_app/helpers/utils.dart';
import 'package:tmdb_app/models/m_upcoming_movies.dart';
import 'package:tmdb_app/screens/movie_details.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});

  final UpcomingMovie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Image.network(
              '${Utils.tmdbImageBase}/${movie.backdropPath}',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
            Container(
              width: double.infinity,
              height: 200,
              color: AppColors.overlayColor.withOpacity(0.4),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                movie.title!,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetailsScreen(movieId: movie.id!),
        ),
      ),
    );
  }
}
