import 'package:bet/user/data/di/user_service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../event/update_or_delete_user_event.dart';
part '../state/update_or_delete_user_state.dart';

class UpdateOrDeleteUserBloc
    extends Bloc<UpdateOrDeleteUserEvent, UpdateOrDeleteUserState> {
  UpdateOrDeleteUserBloc(this._userRepository)
      : super(const UpdateOrDeleteUserState()) {
    on<UserUpdateEventUserInitialValueAdded>(
        _onUserUpdateEventUserInitialValueAdded);
    on<UserUpdateEventUserTypeAdded>(_onUserUpdateEventUserTypeAdded);
    on<UserUpdateEventFirstNameAdded>(_onUserUpdateEventFirstNameAdded);
    on<UserUpdateEventMiddleNameAdded>(_onUserUpdateEventMiddleNameAdded);
    on<UserUpdateEventLastNameAdded>(_onUserUpdateEventLastNameAdded);
    on<UserUpdateEventUserNameAdded>(_onUserUpdateEventUserNameAdded);
    on<UserUpdateEventCreatedByAdded>(_onUserUpdateEventCreatedByAdded);
    on<UserUpdated>(_onUserUpdated);
    on<UserDeleted>(_onUserDeleteEvent);
    on<UserUpdateInitialized>(_onUserUpdateInitialized);
  }

  final UserRepository _userRepository;

  void _onUserUpdateEventUserInitialValueAdded(
      UserUpdateEventUserInitialValueAdded event,
      Emitter<UpdateOrDeleteUserState> emit) {
    emit(state.copyWith(updateUserInput: event.userInitialValue));
  }

  void _onUserUpdateEventUserTypeAdded(UserUpdateEventUserTypeAdded event,
      Emitter<UpdateOrDeleteUserState> emit) {
    emit(state.copyWith(
        updateUserInput:
            state.updateUserInput.copyWith(userType: event.userType)));
  }

  void _onUserUpdateEventFirstNameAdded(UserUpdateEventFirstNameAdded event,
      Emitter<UpdateOrDeleteUserState> emit) {
    emit(state.copyWith(
        updateUserInput:
            state.updateUserInput.copyWith(firstName: event.firstName)));
  }

  void _onUserUpdateEventMiddleNameAdded(UserUpdateEventMiddleNameAdded event,
      Emitter<UpdateOrDeleteUserState> emit) {
    emit(state.copyWith(
        updateUserInput:
            state.updateUserInput.copyWith(middleName: event.middleName)));
  }

  void _onUserUpdateEventLastNameAdded(UserUpdateEventLastNameAdded event,
      Emitter<UpdateOrDeleteUserState> emit) {
    emit(state.copyWith(
        updateUserInput:
            state.updateUserInput.copyWith(lastName: event.lastName)));
  }

  void _onUserUpdateEventUserNameAdded(UserUpdateEventUserNameAdded event,
      Emitter<UpdateOrDeleteUserState> emit) {
    emit(state.copyWith(
        updateUserInput:
            state.updateUserInput.copyWith(userName: event.userName)));
  }

  void _onUserUpdateEventCreatedByAdded(UserUpdateEventCreatedByAdded event,
      Emitter<UpdateOrDeleteUserState> emit) {
    emit(state.copyWith(
        updateUserInput:
            state.updateUserInput.copyWith(createdBy: event.createdBy)));
  }

  void _onUserUpdated(
      UserUpdated event, Emitter<UpdateOrDeleteUserState> emit) async {
    try {
      emit(state.copyWith(updateStatus: UpdateOrDeleteUserStatus.loading));

      await _userRepository.updateUser(
          userId: event.id, input: state.updateUserInput);

      emit(
        state.copyWith(
          updateStatus: UpdateOrDeleteUserStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(updateStatus: UpdateOrDeleteUserStatus.error));
    }
  }

  void _onUserDeleteEvent(
      UserDeleted event, Emitter<UpdateOrDeleteUserState> emit) async {
    try {
      emit(state.copyWith(deleteStatus: UpdateOrDeleteUserStatus.loading));

      await _userRepository.deleteUser(userId: event.id);

      emit(
        state.copyWith(
          deleteStatus: UpdateOrDeleteUserStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(deleteStatus: UpdateOrDeleteUserStatus.error));
    }
  }

  void _onUserUpdateInitialized(
      UserUpdateInitialized event, Emitter<UpdateOrDeleteUserState> emit) {
    emit(
      state.copyWith(
        updateUserInput: UpdateUserInput(
          userType: event.user.type.name,
          firstName: event.user.firstName,
          middleName: event.user.middleName,
          lastName: event.user.lastName,
          userName: event.user.username,
          createdBy: event.user.createdBy,
        ),
      ),
    );
  }
}
