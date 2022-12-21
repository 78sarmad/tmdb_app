import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb_app/helpers/assets.dart';
import 'package:tmdb_app/helpers/colors.dart';

class SearchAppBar extends StatelessWidget with PreferredSizeWidget {
  SearchAppBar({
    super.key,
    required this.searchController,
    required this.hideFunction,
  });

  final TextEditingController searchController;
  final Function hideFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          prefixIcon: InkWell(
            child: SvgPicture.asset(AppAssets.searchIcon),
            onTap: () {},
          ),
          prefixIconConstraints:
              const BoxConstraints(maxWidth: 50, maxHeight: 25),
          suffixIcon: InkWell(
            child: SvgPicture.asset(AppAssets.cancelIcon),
            onTap: () => hideFunction(),
          ),
          suffixIconConstraints:
              const BoxConstraints(maxWidth: 50, maxHeight: 20),
          filled: true,
          fillColor: AppColors.secondaryColor,
          focusColor: AppColors.primaryColor,
          hintText: 'TV shows, movies and more...',
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
