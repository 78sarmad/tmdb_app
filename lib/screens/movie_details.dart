import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:tmdb_app/helpers/assets.dart';
import 'package:tmdb_app/helpers/colors.dart';
import 'package:tmdb_app/helpers/utils.dart';
import 'package:tmdb_app/models/m_movie_details.dart';
import 'package:tmdb_app/services/data_provider.dart';
import 'package:tmdb_app/widgets/w_custom_appbar.dart';
import 'package:tmdb_app/widgets/w_loading_indicator.dart';

class MovieDetailsScreen extends ConsumerStatefulWidget {
  const MovieDetailsScreen({super.key, required this.movieId});

  final int movieId;

  @override
  ConsumerState<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends ConsumerState<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final movieDetails = ref.watch(DataProvider.movieDetailsProvider(724495));

    return Scaffold(
      body: movieDetails.when(
        loading: () => const LoadingIndicator(),
        error: ((error, stackTrace) => Center(
              child: Text('$error'),
            )),
        data: (movieDetails) {
          return Column(
            children: [
              buildMovieHeader(movieDetails),
              const SizedBox(height: 10),
              buildMovieBody(movieDetails),
            ],
          );
        },
      ),
    );
  }

  Widget buildMovieHeader(MovieDetails movieDetails) {
    final DateTime releaseDate = DateTime.parse(movieDetails.releaseDate!);

    return Stack(
      children: [
        Image.network(
          '${Utils.tmdbImageBase}/${movieDetails.posterPath}',
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.55,
          fit: BoxFit.fill,
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
          height: MediaQuery.of(context).size.height * 0.55,
          width: double.infinity,
          color: AppColors.overlayColor.withOpacity(0.4),
        ),
        Positioned(
          top: 50,
          child: CustomAppBar(
            leadingWidget: InkWell(
              child: SvgPicture.asset(
                AppAssets.arrowLeftIcon,
                height: 40,
                color: AppColors.secondaryColor,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            titleWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child:
                  Text('Watch', style: Theme.of(context).textTheme.headline6),
            ),
          ),
        ),
        Positioned(
          bottom: 150,
          left: 40,
          right: 40,
          child: SizedBox(
            height: 50,
            child: Text(
              'In Theatres ${DateFormat('EEEE, dd-MMM-yyyy').format(releaseDate)}',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: 100,
          right: 100,
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              child: Text(
                'Get Tickets',
                style: Theme.of(context).textTheme.headline6,
              ),
              onPressed: () {},
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          left: 100,
          right: 100,
          child: SizedBox(
            height: 50,
            child: OutlinedButton(
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                  BorderSide(color: AppColors.buttonColor),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppAssets.playIcon,
                      width: 25, height: 25, color: AppColors.secondaryColor),
                  const SizedBox(width: 10),
                  Text(
                    'Watch Trailer',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMovieBody(MovieDetails movieDetails) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Genres', style: Theme.of(context).textTheme.bodyText1),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: movieDetails.genres!.length,
              itemBuilder: (context, index) {
                final genre = movieDetails.genres![index];

                return Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: AppColors.badgeColors[index],
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(genre.name!,
                        style: Theme.of(context).textTheme.bodyText2),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Text('Overview', style: Theme.of(context).textTheme.bodyText1),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Text(
              movieDetails.overview!,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppColors.inactiveColor,
                    fontSize: 16,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
