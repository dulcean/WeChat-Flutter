import 'package:WeChat/configs/app_colors.dart';
import 'package:WeChat/configs/app_theme.dart';
import 'package:WeChat/gen/assets.gen.dart';
import 'package:WeChat/presentation/pages/features/friends_page.dart';
import 'package:WeChat/presentation/pages/features/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../blocs/navigation/cubit/navigation_cubit.dart';

class AnimatedNavigationBottomBar extends StatefulWidget {
  const AnimatedNavigationBottomBar({super.key});

  @override
  State<AnimatedNavigationBottomBar> createState() =>
      _AnimatedNavigationBottomBarState();
}

class _AnimatedNavigationBottomBarState
    extends State<AnimatedNavigationBottomBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late PageController _pageController;

  final _icons = [
    Assets.vectors.navigatorIcons.chats,
    Assets.vectors.navigatorIcons.friends,
    Assets.vectors.navigatorIcons.settings,
  ];

  final _labels = [
    "Chats",
    "Friends",
    "Settings",
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _colorAnimation = ColorTween(
      begin: AppColors.unchoosedColor,
      end: AppTheme.lightTheme.primaryColor,
    ).animate(_controller);
    _controller.forward();

    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          final selectedIndex = state.selectedIndex;

          return Scaffold(
            body: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                context.read<NavigationCubit>().updateIndex(index);
                _controller.reset();
                _controller.forward();
              },
              children: [
                HomePage(),
                FriendsPage(),
                HomePage(),
              ],
            ),
            bottomNavigationBar: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.scaffoldBackgroundColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(_icons.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                          context.read<NavigationCubit>().updateIndex(index);
                          _controller.reset();
                          _controller.forward();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              _icons[index],
                              colorFilter: ColorFilter.mode(
                                selectedIndex == index
                                    ? _colorAnimation.value ??
                                        AppTheme.lightTheme.primaryColor
                                    : AppColors.unchoosedColor,
                                BlendMode.srcIn,
                              ),
                              height: 24,
                              width: 24,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              _labels[index],
                              style: TextStyle(
                                fontSize: 12,
                                color: selectedIndex == index
                                    ? _colorAnimation.value
                                    : AppColors.unchoosedColor,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
