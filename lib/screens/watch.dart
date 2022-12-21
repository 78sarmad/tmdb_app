import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb_app/helpers/assets.dart';
import 'package:tmdb_app/helpers/colors.dart';
import 'package:tmdb_app/models/m_upcoming_movies.dart';
import 'package:tmdb_app/services/data_provider.dart';
import 'package:tmdb_app/services/movie_service.dart';
import 'package:tmdb_app/widgets/w_custom_appbar.dart';
import 'package:tmdb_app/widgets/w_loading_indicator.dart';
import 'package:tmdb_app/widgets/w_movie_card.dart';
import 'package:tmdb_app/widgets/w_search_appbar.dart';

class WatchScreen extends ConsumerStatefulWidget {
  const WatchScreen({super.key});

  @override
  ConsumerState<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends ConsumerState<WatchScreen> {
  final searchController = TextEditingController();
  bool showSearchBar = false;
  MovieService movieService = MovieService();

  void showHideSearch() {
    setState(() => showSearchBar = !showSearchBar);
  }

  void hideSearch() {
    setState(() => showSearchBar = false);
  }

  @override
  Widget build(BuildContext context) {
    final upcomingMovies = ref.watch(DataProvider.upcomingMoviesProvider);

    return Scaffold(
      appBar: getAppBar(),
      body: getMovieListing(upcomingMovies),
    );
  }

  PreferredSizeWidget getAppBar() {
    if (showSearchBar) {
      return SearchAppBar(
          searchController: searchController, hideFunction: hideSearch);
    } else {
      return CustomAppBar(
        titleWidget:
            Text('Watch', style: Theme.of(context).textTheme.headline5),
        actionWidget: InkWell(
          child: SvgPicture.asset(
            AppAssets.searchIcon,
            height: 25,
            color: AppColors.textColor,
          ),
          onTap: () => showHideSearch(),
        ),
      );
    }
  }

  Widget getMovieListing(AsyncValue<UpcomingMovies> upcomingMovies) {
    return upcomingMovies.when(
      loading: () => const LoadingIndicator(),
      error: (error, stackTrace) => Center(child: Text('$error')),
      data: (upcomingMovies) {
        return ListView.builder(
          itemCount: upcomingMovies.results!.length,
          itemBuilder: (context, index) {
            final UpcomingMovie movie = upcomingMovies.results![index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: MovieCard(movie: movie),
            );
          },
        );
      },
    );
  }
}
