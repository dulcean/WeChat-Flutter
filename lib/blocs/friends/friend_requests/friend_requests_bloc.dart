import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:user_repository/user_repository.dart';

import '../../../models/friend.dart';

part 'friend_requests_event.dart';
part 'friend_requests_state.dart';

class FriendRequestsBloc
    extends Bloc<FriendRequestsEvent, FriendRequestsState> {
  final CardSwiperController cardSwiperController;
  final UserFriendsRepository userFriendsRepository;
  final UserRepository userRepository;
  final UserProfileRepository userProfileRepository;
  FriendRequestsBloc({
    required this.cardSwiperController,
    required this.userFriendsRepository,
    required this.userRepository,
    required this.userProfileRepository,
  }) : super(FriendRequestsInitial()) {
    on<SwipeLeftEvent>((event, emit) async {
      cardSwiperController.swipe(CardSwiperDirection.left);
      try {
        await userFriendsRepository.acceptFriendRequest(event.userId);
        emit(
          CardSwipedState(event.userId),
        );
      } catch (e) {
        log(e.toString());
      }
    });
    on<SwipeRightEvent>((event, emit) {
      cardSwiperController.swipe(CardSwiperDirection.right);
    });
    on<CloseModalEvent>((event, emit) {
      emit(ModalCloseState());
    });
    on<LoadFriendRequestsEvent>((event, emit) async {
      await _onLoadFriendRequests(event, emit);
    });
  }

  Future<void> _onLoadFriendRequests(
      LoadFriendRequestsEvent event, Emitter<FriendRequestsState> emit) async {
    emit(FriendRequestsLoading());
    try {
      final currentUserId = userRepository.getCurrentId();
      final userIds = await userFriendsRepository
          .getPendingFriendRequestUserIds(currentUserId!);
      final List<Friend> results = [];
      for (var userId in userIds) {
        final user = await userRepository.getUserById(userId);
        final userProfile = await userProfileRepository.getUserProfile(userId);

        results.add(Friend(
            userId: user!.userId,
            name: user.name,
            weTag: userProfile!.weTag,
            photoUrl: userProfile.photoUrl));
      }
      emit(FriendRequestsLoaded(results));
    } catch (e) {
      emit(FriendRequestsInitial());
    }
  }
}
