import 'package:bet/common/component/button/primary_button.dart';
import 'package:bet/common/component/button/secondary_button.dart';
import 'package:bet/common/component/table/custom_data_table.dart';
import 'package:bet/user/data/di/user_service_locator.dart';
import 'package:bet/user/presentation/bloc/create_user_bloc.dart';
import 'package:bet/user/presentation/bloc/update_or_delete_user_bloc.dart';
import 'package:bet/user/presentation/bloc/user_list_bloc.dart';
import 'package:bet/user/presentation/component/delete_user_modal.dart';
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
                onDelete: (user) async {
                  await showDialog(
                    context: context,
                    builder: (_) => BlocProvider<UpdateOrDeleteUserBloc>.value(
                      value: BlocProvider.of<UpdateOrDeleteUserBloc>(
                        context,
                      ),
                      child: DeleteUserModal(
                        userId: user.id,
                      ),
                    ),
                  );
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
            create: (context) => UpdateOrDeleteUserBloc(userRepository)
              ..add(
                UserUpdateInitialized(
                  initialUserValue ?? UserOutput.empty,
                ),
              ),
          ),
          BlocProvider.value(
            value: BlocProvider.of<UserListBloc>(parentContext),
          ),
        ],
        child: BlocConsumer<CreateUserBloc, CreateUserState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              context.read<UserListBloc>().add(UserListFetched());
              Navigator.pop(context);
            }
          },
          builder: (context, createState) {
            return BlocConsumer<UpdateOrDeleteUserBloc,
                UpdateOrDeleteUserState>(
              listener: (context, state) {
                if (state.updateStatus.isSuccess) {
                  context.read<UserListBloc>().add(UserListFetched());
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
                      context
                          .read<CreateUserBloc>()
                          .add(UserCreateEventUserTypeAdded(role));
                    } else {
                      context
                          .read<UpdateOrDeleteUserBloc>()
                          .add(UserUpdateEventUserTypeAdded(role));
                    }
                  },
                  onFirstNameChanged: (value) {
                    if (modalType.isAdd) {
                      context
                          .read<CreateUserBloc>()
                          .add(UserCreateEventFirstNameAdded(value));
                    } else {
                      context
                          .read<UpdateOrDeleteUserBloc>()
                          .add(UserUpdateEventFirstNameAdded(value));
                    }
                  },
                  onMiddleNameChanged: (value) {
                    if (modalType.isAdd) {
                      context
                          .read<CreateUserBloc>()
                          .add(UserCreateEventMiddleNameAdded(value));
                    } else {
                      context
                          .read<UpdateOrDeleteUserBloc>()
                          .add(UserUpdateEventMiddleNameAdded(value));
                    }
                  },
                  onLastNameChanged: (value) {
                    if (modalType.isAdd) {
                      context
                          .read<CreateUserBloc>()
                          .add(UserCreateEventLastNameAdded(value));
                    } else {
                      context
                          .read<UpdateOrDeleteUserBloc>()
                          .add(UserUpdateEventLastNameAdded(value));
                    }
                  },
                  onUsernameChanged: (value) {
                    if (modalType.isAdd) {
                      context
                          .read<CreateUserBloc>()
                          .add(UserCreateEventUserNameAdded(value));
                    } else {
                      context
                          .read<UpdateOrDeleteUserBloc>()
                          .add(UserUpdateEventUserNameAdded(value));
                    }
                  },
                  onCreatedByChanged: (value) {
                    if (modalType.isAdd) {
                      context
                          .read<CreateUserBloc>()
                          .add(UserCreateEventCreatedByAdded(value));
                    } else {
                      context
                          .read<UpdateOrDeleteUserBloc>()
                          .add(UserUpdateEventCreatedByAdded(value));
                    }
                  },
                  createOrUpdateButtonOnPressed: () {
                    if (modalType.isAdd) {
                      context.read<CreateUserBloc>().add(UserCreated());
                    } else {
                      context.read<UpdateOrDeleteUserBloc>().add(UserUpdated(
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
