import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

import '../../../models/friend.dart';

part 'find_friend_event.dart';
part 'find_friend_state.dart';

class FindFriendBloc extends Bloc<FindFriendEvent, FindFriendState> {
  final UserFriendsRepository userFriendsRepository;
  final UserRepository userRepository;
  final UserProfileRepository userProfileRepository;
  FindFriendBloc({
    required this.userFriendsRepository,
    required this.userProfileRepository,
    required this.userRepository,
  }) : super(SearchInitial()) {
    on<SearchQueryChanged>((event, emit) async {
      List<Friend> results = [];
      emit(SearchLoading());
      try {
        final nameMatches =
            await userFriendsRepository.searchUsers(event.query);
        for (var userId in nameMatches) {
          final user = await userRepository.getUserById(userId);
          final userProfile =
              await userProfileRepository.getUserProfile(userId);

          results.add(Friend(
              userId: user!.userId,
              name: user.name,
              weTag: userProfile!.weTag,
              photoUrl: userProfile.photoUrl));
        }
        if (event.query.isEmpty) {
          emit(SearchInitial());
        } else {
          emit(
            SearchSuccess(results: results),
          );
        }
      } catch (e) {
        emit(
          SearchFailure(
            error: e.toString(),
          ),
        );
      }
    });
  }
}
