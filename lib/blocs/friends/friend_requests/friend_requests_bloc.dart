import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

part 'friend_requests_event.dart';
part 'friend_requests_state.dart';

class FriendRequestsBloc extends Bloc<FriendRequestsEvent, FriendRequestsState> {
  final CardSwiperController cardSwiperController;



  FriendRequestsBloc({required this.cardSwiperController,}) : super(FriendRequestsInitial()) {
    on<SwipeLeftEvent>((event, emit) {
      cardSwiperController.swipe(CardSwiperDirection.left);
      emit(const CardSwipedState());
      emit(FriendRequestsInitial());
    });
    on<SwipeRightEvent>((event, emit) {
      cardSwiperController.swipe(CardSwiperDirection.right);
      emit(const CardSwipedRightState());
      emit(FriendRequestsInitial());
    });
    on<CloseModalEvent>((event, emit) {
      emit(ModalCloseState());
    });
  }
}
