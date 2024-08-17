import 'package:bet/user/data/di/user_service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../event/account_event.dart';
part '../state/account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc(this._userRepository) : super(const AccountState()) {
    on<AccountEventLoggedUserRequested>(_onAccountEventLoggedUserRequested);
  }

  final UserRepository _userRepository;

  void _onAccountEventLoggedUserRequested(
      AccountEventLoggedUserRequested event, Emitter<AccountState> emit) async {
    try {
      emit(state.copyWith(status: AccountStatus.loading));

      final user = await _userRepository.getLoggedUser();

      emit(
        state.copyWith(
          userId: user.id,
          userOutput: user,
          status: AccountStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: AccountStatus.error));
    }
  }
}
