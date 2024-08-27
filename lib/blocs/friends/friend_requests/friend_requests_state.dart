part of 'friend_requests_bloc.dart';

sealed class FriendRequestsState extends Equatable {
  const FriendRequestsState();

  @override
  List<Object> get props => [];
}

final class FriendRequestsInitial extends FriendRequestsState {}

final class CardSwipedState extends FriendRequestsState {
  const CardSwipedState(this.userId);
  final String userId;
  @override
  List<Object> get props => [userId];
}

final class CardSwipedRightState extends FriendRequestsState {
  const CardSwipedRightState(this.userId);
  final String userId;
  @override
  List<Object> get props => [userId];
}

final class ModalCloseState extends FriendRequestsState {}

class FriendRequestsLoaded extends FriendRequestsState {
  final List<Friend> pendingRequestUserIds;

  const FriendRequestsLoaded(this.pendingRequestUserIds);
}

class FriendRequestsLoading extends FriendRequestsState {}

class FriendRequestsContinue extends FriendRequestsState {}