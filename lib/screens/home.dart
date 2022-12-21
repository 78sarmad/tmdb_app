import 'package:flutter/material.dart';
import 'package:tmdb_app/helpers/colors.dart';
import 'package:tmdb_app/helpers/routes.dart';
import 'package:tmdb_app/helpers/utils.dart';
import 'package:tmdb_app/widgets/w_main_wrapper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();
  var selectedIndex = AppRoutes.navigationRoutes.indexOf(AppRoutes.watchRoute);

  @override
  Widget build(BuildContext context) {
    AppRoutes.setActiveRoute(selectedIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageController.hasClients) {
        pageController.animateToPage(
          selectedIndex,
          duration: Utils.animationDuration,
          curve: Utils.animationCurve,
        );
      }
    });

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(
          AppRoutes.navigationRoutes.length,
          (index) {
            return BottomNavigationBarItem(
              icon: AppRoutes.navigationRoutes[index].getIcon(),
              label: AppRoutes.navigationRoutes[index].name,
            );
          },
        ),
        currentIndex: selectedIndex,
        selectedItemColor: AppColors.activeColor,
        unselectedItemColor: AppColors.inactiveColor,
        showUnselectedLabels: true,
        onTap: (menuIndex) {
          AppRoutes.setActiveRoute(menuIndex);
          setState(() => selectedIndex = menuIndex);
        },
      ),
      body: MainWrapper(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            AppRoutes.navigationRoutes.length,
            (index) => AppRoutes.navigationRoutes[index].screen,
          ),
        ),
      ),
    );
  }
}
