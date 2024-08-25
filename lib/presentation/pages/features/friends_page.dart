import 'package:WeChat/blocs/friends/friend_requests/friend_requests_bloc.dart';
import 'package:WeChat/configs/app_theme.dart';
import 'package:WeChat/presentation/components/text_editing/search_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import 'requests_page.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final searchController = TextEditingController();
  final cardSwiperController = CardSwiperController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    controller: searchController,
                    hintText: 'Type W-Tag of user or name...',
                    onTap: () {},
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
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
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              final cardSwiperController =
                                  CardSwiperController();

                              return BlocProvider(
                                create: (context) => FriendRequestsBloc(
                                    cardSwiperController: cardSwiperController),
                                child: BottomModalScreen(),
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Requests',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      // InkWell(
                      //   onTap: () {},
                      //   child: const Icon(
                      //     Icons.more_vert,
                      //     color: Colors.white,
                      //     size: 20,
                      //   ),
                      // ),
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
                            const DropdownMenuItem<Divider>(
                                enabled: false, child: Divider()),
                            DropdownMenuItem<MenuItem>(
                              value: MenuItems.removeFriend,
                              child:
                                  MenuItems.buildItem(MenuItems.removeFriend),
                            ),
                          ],
                          onChanged: (Object) {},
                          dropdownStyleData: DropdownStyleData(
                            width: 160,
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
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
        ],
      ),
    );
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
        const SizedBox(
          width: 10,
        ),
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
