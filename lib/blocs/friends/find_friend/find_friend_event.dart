part of 'find_friend_bloc.dart';

sealed class FindFriendEvent extends Equatable {
  const FindFriendEvent();

  @override
  List<Object> get props => [];
}

class SearchQueryChanged extends FindFriendEvent {
  const SearchQueryChanged({required this.query});
  final String query;

  @override
  List<Object> get props => [query];
}
