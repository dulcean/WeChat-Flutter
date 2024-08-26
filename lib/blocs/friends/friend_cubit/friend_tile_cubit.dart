import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'friend_tile_state.dart';

class FriendTileCubit extends Cubit<FriendTileState> {
  final UserFriendsRepository userFriendsRepository;
  final UserProfileRepository userProfileRepository;
  FriendTileCubit({
    required this.userFriendsRepository,
    required this.userProfileRepository,
  }) : super(FriendTileInitial());

  Future<void> sendFriendRequest(String weTag) async {
    emit(FriendTileInitial());
    try {
      final String? userId =
          await userProfileRepository.getUserIdByWeTag(weTag);
      await userFriendsRepository.sendFriendRequest(userId!);
      emit(
        const FriendTileSent(uid: 'userId'),
      );
    } catch (e) {
      emit(FriendTileError());
      log(e.toString());
      rethrow;
    }
  }
}
