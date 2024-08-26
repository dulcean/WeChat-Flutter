import 'package:WeChat/blocs/friends/find_friend/find_friend_bloc.dart';
import 'package:WeChat/blocs/friends/friend_cubit/friend_tile_cubit.dart';
import 'package:WeChat/presentation/components/movement/circular.dart';
import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_repository/user_repository.dart';

import '../../../configs/app_theme.dart';
import '../../../gen/assets.gen.dart';
import '../../components/friend_page/friend_add_tile.dart';
import '../../components/text_editing/search_field.dart';

class SearchFriend extends StatefulWidget {
  const SearchFriend({super.key});

  @override
  State<SearchFriend> createState() => _SearchFriendState();
}

class _SearchFriendState extends State<SearchFriend> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FriendTileCubit(
        userFriendsRepository: RepositoryProvider.of<UserFriendsRepository>(context, listen: false),
        userProfileRepository: RepositoryProvider.of<UserProfileRepository>(context, listen: false),
      ),
      child: Scaffold(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        body: Column(
          children: [
            Container(
              height: 135,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.primaryColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).pop();
                        },
                        child: Image.asset(Assets.images.icons.arrowIcon.path),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SearchArea(
                      controller: searchController,
                      hintText: 'Type W-Tag of user or name...',
                      onTap: () {
                        context.read<FindFriendBloc>().add(
                              SearchQueryChanged(query: searchController.text),
                            );
                      },
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<FindFriendBloc, FindFriendState>(
                builder: (context, state) {
                  if (state is SearchSuccess) {
                    return AnimationList(
                      reBounceDepth: 10,
                      duration: 100,
                      children: state.results.map((item) {
                        return FriendAddTile(
                            title: item.name,
                            subtitle: item.weTag,
                            avatarUrl: item.photoUrl,
                            backgroundColor: AppTheme.lightTheme.cardColor);
                      }).toList(),
                    );
                  } else if (state is SearchLoading) {
                    return const Align(
                        alignment: Alignment.center,
                        child: GradientCircularProgressIndicator());
                  } else if (state is SearchInitial) {
                    return Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          'Search for friends',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.lightTheme.primaryColor,
                          ),
                        ),
                      ),
                    );
                  } else if (state is SearchFailure) {
                    return Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          'Error:${state.error}',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.lightTheme.primaryColor,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Align(
                        alignment: Alignment.center,
                        child: GradientCircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
