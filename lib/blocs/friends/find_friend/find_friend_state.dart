part of 'find_friend_bloc.dart';

sealed class FindFriendState extends Equatable {
  const FindFriendState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends FindFriendState {}

class SearchLoading extends FindFriendState {}

class SearchSuccess extends FindFriendState {
  final List<Friend> results;

  const SearchSuccess({required this.results});

  @override
  List<Object> get props => [results];
}

class SearchFailure extends FindFriendState {
  final String error;

  const SearchFailure({required this.error});

  @override
  List<Object> get props => [error];
}
