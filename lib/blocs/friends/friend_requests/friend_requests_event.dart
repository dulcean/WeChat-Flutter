part of 'friend_requests_bloc.dart';

sealed class FriendRequestsEvent extends Equatable {
  const FriendRequestsEvent();

  @override
  List<Object> get props => [];
}

class InitializeEvent extends FriendRequestsEvent {}

class SwipeLeftEvent extends FriendRequestsEvent {}

class SwipeRightEvent extends FriendRequestsEvent {}

class CloseModalEvent extends FriendRequestsEvent {}
