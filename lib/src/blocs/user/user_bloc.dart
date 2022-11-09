import 'package:auto_pedia/src/service/services.dart';
import 'package:auto_pedia/src/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/models.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUserData>(
      (event, emit) async {
        emit(UserIsLoading());
        String uid = await Commons().getUID();
        final result = await UserService().loadUserData(uid);
        emit(
          result.fold(
            (l) => UserIsFailed(message: l),
            (r) => UserIsSuccess(data: r),
          ),
        );
      },
    );
    on<LogOutUser>(
      (event, emit) async {
        UserService().logOutUser();
        await Commons().removeUid();
        emit(UserisLogout());
      },
    );
  }
}
