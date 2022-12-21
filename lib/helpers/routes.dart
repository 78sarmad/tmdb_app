import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/helpers/assets.dart';
import 'package:tmdb_app/helpers/colors.dart';
import 'package:tmdb_app/screens/dashboard.dart';
import 'package:tmdb_app/screens/home.dart';
import 'package:tmdb_app/screens/watch.dart';
import 'package:tmdb_app/screens/media.dart';
import 'package:tmdb_app/screens/more.dart';

class Route {
  String name;
  String path;
  Widget screen;
  String? iconPath;
  bool isActive;

  Route({
    required this.name,
    required this.path,
    required this.screen,
    this.iconPath,
    this.isActive = false,
  });

  Widget getIcon() {
    if (iconPath != null) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: SvgPicture.asset(iconPath!,
            height: 25,
            color: isActive ? AppColors.activeColor : AppColors.inactiveColor),
      );
    } else {
      return Container();
    }
  }
}

class AppRoutes {
  static Route homeRoute = Route(
    name: 'Home',
    path: '/home',
    screen: const HomeScreen(),
  );
  static Route dashboardRoute = Route(
    name: 'Dashboard',
    path: '/dashboard',
    screen: const DashboardScreen(),
    iconPath: AppAssets.dashboardIcon,
  );
  static Route watchRoute = Route(
    name: 'Watch',
    path: '/watch',
    screen: const WatchScreen(),
    iconPath: AppAssets.playIcon,
  );
  static Route mediaRoute = Route(
    name: 'Media',
    path: '/media',
    screen: const MediaScreen(),
    iconPath: AppAssets.mediaIcon,
  );
  static Route moreRoute = Route(
    name: 'More',
    path: '/more',
    screen: const MoreScreen(),
    iconPath: AppAssets.moreIcon,
  );

  static List<Route> navigationRoutes = [
    dashboardRoute,
    watchRoute,
    mediaRoute,
    moreRoute,
  ];

  static final GoRouter routerConfig = GoRouter(
    initialLocation: homeRoute.path,
    routes: <RouteBase>[
      GoRoute(
        name: homeRoute.name,
        path: homeRoute.path,
        builder: (_, __) => homeRoute.screen,
      ),
      GoRoute(
        name: dashboardRoute.name,
        path: dashboardRoute.path,
        builder: (_, __) => dashboardRoute.screen,
      ),
      GoRoute(
        name: watchRoute.name,
        path: watchRoute.path,
        builder: (_, __) => watchRoute.screen,
      ),
      GoRoute(
        name: mediaRoute.name,
        path: mediaRoute.path,
        builder: (_, __) => mediaRoute.screen,
      ),
      GoRoute(
        name: moreRoute.name,
        path: moreRoute.path,
        builder: (_, __) => moreRoute.screen,
      ),
    ],
  );

  static void setActiveRoute(int routeIndex) {
    for (var route in navigationRoutes) {
      route.isActive = false;
    }

    navigationRoutes[routeIndex].isActive = true;
  }
}
