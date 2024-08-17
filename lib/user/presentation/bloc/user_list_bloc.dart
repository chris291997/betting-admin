import 'package:bet/user/data/di/user_service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../event/user_list_event.dart';
part '../state/user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc(this._userRepository) : super(const UserListState()) {
    on<UserListFetched>(_onUserListFetched);
  }

  final UserRepository _userRepository;

  void _onUserListFetched(
      UserListFetched event, Emitter<UserListState> emit) async {
    try {
      emit(state.copyWith(status: UserListStatus.loading));

      final users = await _userRepository.getUsers();

      emit(state.copyWith(status: UserListStatus.loaded, users: users));
    } catch (e) {
      emit(state.copyWith(status: UserListStatus.error));
    }
  }
}
