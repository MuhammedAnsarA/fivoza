import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fivoza/core/usecases/usecase.dart';
import 'package:fivoza/core/utils/enum.dart';
import 'package:fivoza/core/utils/extension.dart';
import 'package:fivoza/domain/usecases/auth/send_email_verification_usecase.dart';
import 'package:fivoza/domain/usecases/auth/sign_up_params.dart';
import 'package:fivoza/domain/usecases/auth/user_sign_up_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserSignUpUsecase userSignUpUseCase;
  final SendEmailVerificationUsecase sendEmailVerificationUseCase;
  SignUpBloc(
    this.userSignUpUseCase,
    this.sendEmailVerificationUseCase,
  ) : super(const SignUpState()) {
    on<SignUpButtonClickedEvent>(onSignUpButtonClickedEvent);
    on<SendEmailButtonClickedEvent>(onSendEmailButtonClickedEvent);
    on<SetSignUpStatusToDefault>(onSetSignUpStatusToDefault);
  }

  FutureOr<void> onSignUpButtonClickedEvent(
      SignUpButtonClickedEvent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading));
    final result = await userSignUpUseCase.call(event.signUpParams);
    result.fold(
      (l) => emit(state.copyWith(
          authMessage: l.errorMessage, status: BlocStatus.error)),
      (r) {
        emit(state.copyWith(status: BlocStatus.success));
        add(SendEmailButtonClickedEvent());
      },
    );
  }

  FutureOr<void> onSendEmailButtonClickedEvent(
      SendEmailButtonClickedEvent event, Emitter<SignUpState> emit) async {
    final result = await sendEmailVerificationUseCase.call(NoParams());
    result.fold(
      (l) => emit(state.copyWith(
          authMessage: l.errorMessage, status: BlocStatus.error)),
      (r) {
        if (r == ResponseTypes.success.response) {
          emit(state.copyWith(authMessage: r, status: BlocStatus.success));
        } else {
          emit(state.copyWith(authMessage: r, status: BlocStatus.error));
        }
      },
    );
  }

  FutureOr<void> onSetSignUpStatusToDefault(
      SetSignUpStatusToDefault event, Emitter<SignUpState> emit) {
    emit(
      state.copyWith(
        signUpParams: const SignUpParams(
          userName: '',
          email: '',
          password: '',
        ),
        status: BlocStatus.initial,
        authMessage: '',
      ),
    );
  }
}
