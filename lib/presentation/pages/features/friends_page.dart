import 'package:WeChat/blocs/friends/friend_requests/friend_requests_bloc.dart';
import 'package:WeChat/configs/app_theme.dart';
import 'package:WeChat/configs/router_constants.dart';
import 'package:WeChat/gen/assets.gen.dart';
import 'package:WeChat/presentation/components/text_editing/search_field.dart';
import 'package:animation_list/animation_list.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:user_repository/user_repository.dart';

import '../../components/friend_page/friend_tile.dart';
import 'requests_page.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cardSwiperController = CardSwiperController();

    return MultiBlocProvider(
      providers: [
        BlocProvider<FriendRequestsBloc>(
          create: (context) => FriendRequestsBloc(
            cardSwiperController: cardSwiperController,
            userFriendsRepository:
                RepositoryProvider.of<UserFriendsRepository>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context),
            userProfileRepository:
                RepositoryProvider.of<UserProfileRepository>(context),
          )..add(LoadFriendRequestsEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        body: Column(
          children: [
            Container(
              height: 135,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.primaryColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 35),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SearchArea(
                      controller: TextEditingController(),
                      hintText: 'Type W-Tag of user or name...',
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Friends',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 20),
                        BlocBuilder<FriendRequestsBloc, FriendRequestsState>(
                          builder: (contextBlock, state) {
                            return GestureDetector(
                              onTap: () {
                                final friendRequestsBloc =
                                    BlocProvider.of<FriendRequestsBloc>(
                                        contextBlock);
                                showModalBottomSheet(
                                  context: contextBlock,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (contextBlock) {
                                    return BlocProvider.value(
                                      value: friendRequestsBloc,
                                      child: const BottomModalScreen(),
                                    );
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  const Text(
                                    'Requests',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: Color.fromARGB(98, 255, 255, 255),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  BlocBuilder<FriendRequestsBloc,
                                      FriendRequestsState>(
                                    builder: (context, state) {
                                      if (state is FriendRequestsLoaded) {
                                        return Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            state.pendingRequestUserIds.length
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const Spacer(),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            customButton: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 20,
                            ),
                            items: [
                              DropdownMenuItem<MenuItem>(
                                value: MenuItems.addFriend,
                                child: MenuItems.buildItem(MenuItems.addFriend),
                              ),
                              DropdownMenuItem<MenuItem>(
                                value: MenuItems.removeFriend,
                                child:
                                    MenuItems.buildItem(MenuItems.removeFriend),
                              ),
                            ],
                            onChanged: (val) {
                              if (val != null) onChanged(context, val);
                            },
                            dropdownStyleData: DropdownStyleData(
                              width: 160,
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              offset: const Offset(0, 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: AnimationList(
                reBounceDepth: 10,
                duration: 100,
                children: [
                  FriendTile(
                    title: 'GOIDA ZOV',
                    subtitle: 'LAVRIK_10000',
                    avatarUrl: Assets.images.icons.asset.path,
                    backgroundColor: AppTheme.lightTheme.cardColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.addFriend:
        GoRouter.of(context).pushNamed(RouterConstants.search);
        break;
      case MenuItems.removeFriend:
        break;
    }
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const addFriend = MenuItem(text: 'Add Friend', icon: Icons.person_add);
  static const removeFriend =
      MenuItem(text: 'Remove Friend', icon: Icons.person_remove);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: AppTheme.lightTheme.primaryColor, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            item.text,
            style: TextStyle(
              color: AppTheme.lightTheme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
