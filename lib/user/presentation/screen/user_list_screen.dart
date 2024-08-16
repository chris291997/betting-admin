import 'package:bet/common/component/button/primary_button.dart';
import 'package:bet/common/component/button/secondary_button.dart';
import 'package:bet/common/component/table/custom_data_table.dart';
import 'package:bet/user/data/di/user_service_locator.dart';
import 'package:bet/user/presentation/bloc/create_user_bloc.dart';
import 'package:bet/user/presentation/bloc/user_list_bloc.dart';
import 'package:bet/user/presentation/component/user_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  static const String routeName = "/users";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => UserListBloc(userRepository)
            ..add(
              UserListFetched(),
            ),
        ),
      ],
      child: const _UsersScreen(),
    );
  }
}

class _UsersScreen extends StatelessWidget {
  const _UsersScreen();

  static const List<String> _columnNames = [
    'Role',
    'First Name',
    'Middle Name',
    'Last Name',
    'Username',
    'Created By',
  ];
  static final _columns =
      _columnNames.map((column) => DataColumn(label: Text(column))).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          if (state.status.isError) {
            return const Center(child: Text('Failed to fetch events'));
          }

          if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status.isInitial) {
            return const SizedBox();
          }

          final users = state.users;

          return Center(
            child: SizedBox(
              width: 1000,
              child: CustomDataTable<UserOutput>(
                columns: _columns,
                objects: users,
                onSelectChanged: (_) => {},
              ),
            ),
          );
        },
      ),
      floatingActionButton: SecondaryButton(
        height: 30,
        width: 120,
        onPressed: () => _showEventModal(context),
        labelText: 'Add User',
      ),
    );
  }

  void _showEventModal(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CreateUserBloc(userRepository),
          ),
          BlocProvider.value(
            value: BlocProvider.of<UserListBloc>(parentContext),
          ),
        ],
        child: BlocConsumer<CreateUserBloc, CreateUserState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              BlocProvider.of<UserListBloc>(parentContext)
                  .add(UserListFetched());
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return UserModal(
              type: UserModalType.add,
              createtOrUpdateButtonState: state.status.isLoading
                  ? PrimaryButtonState.loading
                  : PrimaryButtonState.enabled,
              onRoleChanged: (role) =>
                  BlocProvider.of<CreateUserBloc>(parentContext)
                      .add(UserCreateEventUserTypeAdded(role)),
              onFirstNameChanged: (value) =>
                  BlocProvider.of<CreateUserBloc>(parentContext)
                      .add(UserCreateEventFirstNameAdded(value)),
              onMiddleNameChanged: (value) =>
                  BlocProvider.of<CreateUserBloc>(parentContext)
                      .add(UserCreateEventMiddleNameAdded(value)),
              onLastNameChanged: (value) =>
                  BlocProvider.of<CreateUserBloc>(parentContext)
                      .add(UserCreateEventLastNameAdded(value)),
              onUsernameChanged: (value) =>
                  BlocProvider.of<CreateUserBloc>(parentContext)
                      .add(UserCreateEventUserNameAdded(value)),
              onCreatedByChanged: (value) =>
                  BlocProvider.of<CreateUserBloc>(parentContext)
                      .add(UserCreateEventCreatedByAdded(value)),
              createOrUpdateButtonOnPressed: () =>
                  BlocProvider.of<CreateUserBloc>(parentContext)
                      .add(UserCreated()),
            );
          },
        ),
      ),
    );
  }
}
