import 'package:bet/common/component/button/primary_button.dart';
import 'package:bet/common/component/button/secondary_button.dart';
import 'package:bet/common/component/table/custom_data_table.dart';
import 'package:bet/user/data/di/user_service_locator.dart';
import 'package:bet/user/presentation/bloc/create_user_bloc.dart';
import 'package:bet/user/presentation/bloc/update_or_delete_user_bloc.dart';
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
        BlocProvider(
          create: (context) => UpdateOrDeleteUserBloc(userRepository),
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
      appBar: AppBar(title: const Text('Users')),
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
                onDelete: (user) {
                  BlocProvider.of<UpdateOrDeleteUserBloc>(context)
                      .add(UserDeleted(user.id));
                },
                onUpdate: (user) {
                  BlocProvider.of<UpdateOrDeleteUserBloc>(context).add(
                    UserUpdateEventUserInitialValueAdded(
                      UpdateUserInput(
                        firstName: user.firstName,
                        middleName: user.middleName,
                        lastName: user.lastName,
                        userName: user.username,
                        userType: user.type.name,
                        createdBy: user.createdBy,
                      ),
                    ),
                  );
                  _showEventModal(context, UserModalType.edit,
                      initialUserValue: user);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: SecondaryButton(
        height: 30,
        width: 120,
        onPressed: () => _showEventModal(context, UserModalType.add),
        labelText: 'Add User',
      ),
    );
  }

  void _showEventModal(
    BuildContext parentContext,
    UserModalType modalType, {
    UserOutput? initialUserValue,
  }) {
    showDialog(
      context: parentContext,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CreateUserBloc(userRepository),
          ),
          BlocProvider(
            create: (context) => UpdateOrDeleteUserBloc(userRepository),
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
          builder: (context, createState) {
            return BlocConsumer<UpdateOrDeleteUserBloc,
                UpdateOrDeleteUserState>(
              listener: (context, state) {
                if (state.updateStatus.isSuccess) {
                  BlocProvider.of<UserListBloc>(parentContext)
                      .add(UserListFetched());
                  Navigator.pop(context);
                }
              },
              builder: (context, updateState) {
                return UserModal(
                  type: modalType,
                  initialUserValue: initialUserValue ?? const UserOutput(),
                  createtOrUpdateButtonState: createState.status.isLoading ||
                          updateState.updateStatus.isLoading
                      ? PrimaryButtonState.loading
                      : PrimaryButtonState.enabled,
                  onRoleChanged: (role) {
                    if (modalType.isAdd) {
                      BlocProvider.of<CreateUserBloc>(context)
                          .add(UserCreateEventUserTypeAdded(role));
                    } else {
                      BlocProvider.of<UpdateOrDeleteUserBloc>(parentContext)
                          .add(UserUpdateEventUserTypeAdded(role));
                    }
                  },
                  onFirstNameChanged: (value) {
                    if (modalType.isAdd) {
                      BlocProvider.of<CreateUserBloc>(context)
                          .add(UserCreateEventFirstNameAdded(value));
                    } else {
                      BlocProvider.of<UpdateOrDeleteUserBloc>(parentContext)
                          .add(UserUpdateEventFirstNameAdded(value));
                    }
                  },
                  onMiddleNameChanged: (value) {
                    if (modalType.isAdd) {
                      BlocProvider.of<CreateUserBloc>(context)
                          .add(UserCreateEventMiddleNameAdded(value));
                    } else {
                      BlocProvider.of<UpdateOrDeleteUserBloc>(parentContext)
                          .add(UserUpdateEventMiddleNameAdded(value));
                    }
                  },
                  onLastNameChanged: (value) {
                    if (modalType.isAdd) {
                      BlocProvider.of<CreateUserBloc>(context)
                          .add(UserCreateEventLastNameAdded(value));
                    } else {
                      BlocProvider.of<UpdateOrDeleteUserBloc>(parentContext)
                          .add(UserUpdateEventLastNameAdded(value));
                    }
                  },
                  onUsernameChanged: (value) {
                    if (modalType.isAdd) {
                      BlocProvider.of<CreateUserBloc>(context)
                          .add(UserCreateEventUserNameAdded(value));
                    } else {
                      BlocProvider.of<UpdateOrDeleteUserBloc>(parentContext)
                          .add(UserUpdateEventUserNameAdded(value));
                    }
                  },
                  onCreatedByChanged: (value) {
                    if (modalType.isAdd) {
                      BlocProvider.of<CreateUserBloc>(context)
                          .add(UserCreateEventCreatedByAdded(value));
                    } else {
                      BlocProvider.of<UpdateOrDeleteUserBloc>(parentContext)
                          .add(UserUpdateEventCreatedByAdded(value));
                    }
                  },
                  createOrUpdateButtonOnPressed: () {
                    if (modalType.isAdd) {
                      BlocProvider.of<CreateUserBloc>(context)
                          .add(UserCreated());
                    } else {
                      BlocProvider.of<UpdateOrDeleteUserBloc>(parentContext)
                          .add(UserUpdated(
                        initialUserValue?.id ?? '',
                      ));
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
