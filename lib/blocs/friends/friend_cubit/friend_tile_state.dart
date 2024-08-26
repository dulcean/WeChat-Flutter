part of 'friend_tile_cubit.dart';

sealed class FriendTileState extends Equatable {
  const FriendTileState();

  @override
  List<Object> get props => [];
}

final class FriendTileInitial extends FriendTileState {}

final class FriendTileSent extends FriendTileState {
  final String uid;
  const FriendTileSent({required this.uid});

  @override
  List<Object> get props => [uid];
}

final class FriendTileError extends FriendTileState {}
