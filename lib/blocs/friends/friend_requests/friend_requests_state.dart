part of 'friend_requests_bloc.dart';

sealed class FriendRequestsState extends Equatable {
  const FriendRequestsState();

  @override
  List<Object> get props => [];
}

final class FriendRequestsInitial extends FriendRequestsState {}

final class CardSwipedState extends FriendRequestsState {
  const CardSwipedState();
  @override
  List<Object> get props => [];
}

final class CardSwipedRightState extends FriendRequestsState {
  const CardSwipedRightState();
  @override
  List<Object> get props => [];
}

final class ModalCloseState extends FriendRequestsState {}
