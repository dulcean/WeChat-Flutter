part of 'friend_requests_bloc.dart';

sealed class FriendRequestsEvent extends Equatable {
  const FriendRequestsEvent();

  @override
  List<Object> get props => [];
}

class InitializeEvent extends FriendRequestsEvent {}

class SwipeLeftEvent extends FriendRequestsEvent {
  final String userId;

  const SwipeLeftEvent(this.userId);
}

class SwipeRightEvent extends FriendRequestsEvent {
  final String userId;

  const SwipeRightEvent(this.userId);
}

class CloseModalEvent extends FriendRequestsEvent {}

class LoadFriendRequestsEvent extends FriendRequestsEvent {}