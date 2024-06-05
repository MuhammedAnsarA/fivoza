import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fivoza/core/usecases/usecase.dart';
import 'package:fivoza/core/utils/extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fivoza/core/utils/enum.dart';
import 'package:fivoza/domain/usecases/auth/get_auth_user_usecase.dart';
import 'package:fivoza/domain/usecases/auth/refresh_user_usecase.dart';
import 'package:fivoza/domain/usecases/auth/user_sign_out_usecase.dart';
import 'package:fivoza/domain/usecases/user/get_user_type_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetAuthUserUsecase getAuthUserUsecase;
  final GetUserTypeUsecase getUserTypeUsecase;
  final UserSignOutUsecase userSignOutUsecase;
  final RefreshUserUsecase refreshUserUsecase;

  late final StreamSubscription<User?> userSubscription;
  AuthBloc(
    this.getAuthUserUsecase,
    this.getUserTypeUsecase,
    this.userSignOutUsecase,
    this.refreshUserUsecase,
  ) : super(const LoadingState(statusValue: BlocStatus.loading)) {
    on<CheckUserAuthEvent>(onCheckUserAuth);
    on<SignOutEvent>(onSignOutEvent);
    on<RefreshUserEvent>(onRefreshUserEvent);
    on<SetAuthStatusToDefault>(onSetStatusToDefault);

    userSubscription = getAuthUserUsecase.user.listen((user) {
      if (user != null) {
        add(CheckUserAuthEvent(user: user));
      } else {
        add(SetAuthStatusToDefault());
      }
    });
  }

  FutureOr<void> onCheckUserAuth(
      CheckUserAuthEvent event, Emitter<AuthState> emit) async {
    final result = await getUserTypeUsecase.call(event.user!.uid);

    result.fold(
      (l) => emit(const AuthFailureState(statusValue: BlocStatus.error)),
      (r) => emit(AuthSuccessState(
          userValue: event.user!,
          statusValue: BlocStatus.success,
          userTypeValue: r)),
    );
  }

  FutureOr<void> onSignOutEvent(
      SignOutEvent event, Emitter<AuthState> emit) async {
    final result = await userSignOutUsecase.call(NoParams());
    result.fold(
      (l) => emit(const AuthFailureState(statusValue: BlocStatus.error)),
      (r) {
        if (r == ResponseTypes.success.response) {
          emit(const SignOutState(signOutStatusValue: BlocStatus.success));
        } else {
          emit(const SignOutState(signOutStatusValue: BlocStatus.error));
        }
      },
    );
  }

  Future<FutureOr<void>> onRefreshUserEvent(
      RefreshUserEvent event, Emitter<AuthState> emit) async {
    final result = await refreshUserUsecase.refreshUserCall(state.user);
    emit(AuthSuccessState(
        userValue: result!,
        statusValue: BlocStatus.success,
        userTypeValue: state.userType));
  }

  FutureOr<void> onSetStatusToDefault(
      SetAuthStatusToDefault event, Emitter<AuthState> emit) {
    emit(const InitialState(
        statusValue: BlocStatus.initial,
        userTypeValue: '',
        signOutStatusValue: BlocStatus.initial));
  }

  @override
  Future<void> close() {
    userSubscription.cancel();
    return super.close();
  }
}
