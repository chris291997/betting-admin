import 'package:bet/authentication/data/di/auth_service_locator.dart';
import 'package:bet/common/enum/view_model_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../event/auth_event.dart';

part '../state/auth_state.dart';

class AuthViewmodel extends Bloc<AuthEvent, AuthState> {
  AuthViewmodel(this._repository) : super(const AuthState()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLoginUsernameChanged>(_onLoginUsernameChanged);
    on<AuthLoginPasswordChanged>(_onLoginPasswordChanged);
  }

  final AuthRepositoryInterface _repository;

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      if (state.status.isLoading) return;

      emit(state.copyWith(status: ViewModelStatus.loading));

      await _repository.login(input: state.input);

      emit(state.copyWith(status: ViewModelStatus.success));
      emit(state.copyWith(status: ViewModelStatus.idle));
    } catch (error) {
      emit(state.copyWith(status: ViewModelStatus.error));
      emit(state.copyWith(status: ViewModelStatus.idle));
    }
  }

  void _onLoginUsernameChanged(
    AuthLoginUsernameChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        input: state.input.copyWith(
          username: event.username,
        ),
      ),
    );
  }

  void _onLoginPasswordChanged(
    AuthLoginPasswordChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        input: state.input.copyWith(
          password: event.password,
        ),
      ),
    );
  }
}
