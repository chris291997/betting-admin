import 'package:bet/user/data/di/user_service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../event/create_user_event.dart';
part '../state/create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  CreateUserBloc(this._userRepository) : super(const CreateUserState()) {
    on<UserCreateEventUserTypeAdded>(_onUserCreateEventUserTypeAdded);
    on<UserCreateEventFirstNameAdded>(_onUserCreateEventFirstNameAdded);
    on<UserCreateEventMiddleNameAdded>(_onUserCreateEventMiddleNameAdded);
    on<UserCreateEventLastNameAdded>(_onUserCreateEventLastNameAdded);
    on<UserCreateEventUserNameAdded>(_onUserCreateEventUserNameAdded);
    on<UserCreateEventCreatedByAdded>(_onUserCreateEventCreatedByAdded);
    on<UserCreated>(_onUserCreated);
  }

  final UserRepository _userRepository;

  void _onUserCreateEventUserTypeAdded(
      UserCreateEventUserTypeAdded event, Emitter<CreateUserState> emit) {
    emit(state.copyWith(
        userInput: state.userInput.copyWith(userType: event.userType)));
  }

  void _onUserCreateEventFirstNameAdded(
      UserCreateEventFirstNameAdded event, Emitter<CreateUserState> emit) {
    emit(state.copyWith(
        userInput: state.userInput.copyWith(firstName: event.firstName)));
  }

  void _onUserCreateEventMiddleNameAdded(
      UserCreateEventMiddleNameAdded event, Emitter<CreateUserState> emit) {
    emit(state.copyWith(
        userInput: state.userInput.copyWith(middleName: event.middleName)));
  }

  void _onUserCreateEventLastNameAdded(
      UserCreateEventLastNameAdded event, Emitter<CreateUserState> emit) {
    emit(state.copyWith(
        userInput: state.userInput.copyWith(lastName: event.lastName)));
  }

  void _onUserCreateEventUserNameAdded(
      UserCreateEventUserNameAdded event, Emitter<CreateUserState> emit) {
    emit(state.copyWith(
        userInput: state.userInput.copyWith(userName: event.userName)));
  }

  void _onUserCreateEventCreatedByAdded(
      UserCreateEventCreatedByAdded event, Emitter<CreateUserState> emit) {
    emit(state.copyWith(
        userInput: state.userInput.copyWith(createdBy: event.createdBy)));
  }

  void _onUserCreated(UserCreated event, Emitter<CreateUserState> emit) async {
    try {
      emit(state.copyWith(status: CreateUserStatus.loading));

      await _userRepository.createUser(input: state.userInput);

      emit(
        state.copyWith(
          status: CreateUserStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: CreateUserStatus.error));
    }
  }
}
