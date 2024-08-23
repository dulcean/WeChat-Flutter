import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;
  RegisterBloc(this._userRepository) : super(RegisterInitial()) {
    on<RegisterRequired>((event, emit) async {
      try {
        WeUser user = await _userRepository.signUp(
          event.user,
          event.password,
        );
        await _userRepository.setUserData(user);
        emit(RegisterSuccess());
      } catch (e) {
        throw Exception(e.toString());
      }
    });
  }
}
