import 'dart:developer';

import 'package:WeChat/blocs/friends/friend_requests/friend_requests_bloc.dart';
import 'package:WeChat/configs/app_theme.dart';
import 'package:WeChat/models/friend.dart';
import 'package:WeChat/presentation/components/main_elements/friend_card.dart';
import 'package:WeChat/presentation/components/movement/circular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class BottomModalScreen extends StatefulWidget {
  const BottomModalScreen({super.key});

  @override
  State<BottomModalScreen> createState() => _BottomModalScreenState();
}

class _BottomModalScreenState extends State<BottomModalScreen> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    context.read<FriendRequestsBloc>().add(LoadFriendRequestsEvent());
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<FriendRequestsBloc, FriendRequestsState>(
      listener: (context, state) {
        if (state is ModalCloseState) {
          Navigator.of(context).pop();
        } else if (state is CardSwipedState) {
          log('Accepted');
        } else if (state is CardSwipedRightState) {
          log('Rejected');
        }
      },
      child: FractionallySizedBox(
        heightFactor: 0.9,
        widthFactor: 1,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.lightTheme.scaffoldBackgroundColor,
                Colors.lightBlue,
                AppTheme.lightTheme.scaffoldBackgroundColor,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: BlocBuilder<FriendRequestsBloc, FriendRequestsState>(
            builder: (context, state) {
              if (state is FriendRequestsLoading) {
                return const GradientCircularProgressIndicator();
              } else if (state is FriendRequestsLoaded) {
                final List<Friend> userIds = state.pendingRequestUserIds;
                final List<Widget> imageList = userIds.map((item) {
                  return FriendCard(
                      imgPath: item.photoUrl,
                      topTag: item.name,
                      bottomTag: item.weTag);
                }).toList();

                final controller =
                    context.read<FriendRequestsBloc>().cardSwiperController;
                return Column(
                  children: [
                    Flexible(
                      child: CardSwiper(
                        cardBuilder: (
                          context,
                          index,
                          horizontalThresholdPercentage,
                          verticalThresholdPercentage,
                        ) {
                          currentIndex = index;
                          return imageList[index];
                        },
                            
                        cardsCount: imageList.length,
                        numberOfCardsDisplayed:
                            imageList.length < 3 ? imageList.length : 3,
                        controller: controller,
                        allowedSwipeDirection:
                            const AllowedSwipeDirection.symmetric(
                                horizontal: true),
                        scale: 0.9,
                        threshold: 90,
                        onSwipe: _onSwipe,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              final userId = userIds[currentIndex].userId;
                                context.read<FriendRequestsBloc>()
                                .add(SwipeLeftEvent(userId));
                            },
                            backgroundColor: Colors.green,
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                          FloatingActionButton(
                            onPressed: () {
                                context.read<FriendRequestsBloc>()
                                .add(SwipeRightEvent('123'));
                            },
                            backgroundColor: Colors.red,
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<FriendRequestsBloc>(context)
                            .add(CloseModalEvent());
                      },
                      child: const Text(
                        'Close',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                );
              } else {
                return const GradientCircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}

bool _onSwipe(
  int previousIndex,
  int? currentIndex,
  CardSwiperDirection direction,
) {
  debugPrint(
    'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
  );
  return true;
}
