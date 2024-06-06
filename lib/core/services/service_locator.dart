import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fivoza/data/data_sources/remote/auth/user_auth_remote_data_source.dart';
import 'package:fivoza/data/data_sources/remote/user/user_remote_data_source.dart';
import 'package:fivoza/data/repositories/auth/user_auth_repository_impl.dart';
import 'package:fivoza/data/repositories/user/user_repository_impl.dart';
import 'package:fivoza/domain/repositories/auth/user_auth_repository.dart';
import 'package:fivoza/domain/repositories/user/user_repository.dart';
import 'package:fivoza/domain/usecases/auth/check_email_verification_usecase.dart';
import 'package:fivoza/domain/usecases/auth/forgot_password_usecase.dart';
import 'package:fivoza/domain/usecases/auth/get_auth_user_usecase.dart';
import 'package:fivoza/domain/usecases/auth/refresh_user_usecase.dart';
import 'package:fivoza/domain/usecases/auth/send_email_verification_usecase.dart';
import 'package:fivoza/domain/usecases/auth/user_sign_in_usecase.dart';
import 'package:fivoza/domain/usecases/auth/user_sign_out_usecase.dart';
import 'package:fivoza/domain/usecases/auth/user_sign_up_usecase.dart';
import 'package:fivoza/domain/usecases/user/get_all_users_usecase.dart';
import 'package:fivoza/domain/usecases/user/get_user_details_usecase.dart';
import 'package:fivoza/domain/usecases/user/get_user_type_usecase.dart';
import 'package:fivoza/presentation/blocs/auth/auth_bloc.dart';
import 'package:fivoza/presentation/blocs/sign_in/sign_in_bloc.dart';
import 'package:fivoza/presentation/blocs/sign_up/sign_up_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> serviceLocator() async {
  /// firebase
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  // sl.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);

  /// data source
  sl.registerSingleton<UserAuthRemoteDataSource>(
      UserAuthRemoteDataSourceImpl(fireStore: sl(), auth: sl()));
  sl.registerSingleton<UserRemoteDataSource>(
      UserRemoteDataSourceImpl(fireStore: sl(), auth: sl()));

  /// repository
  sl.registerSingleton<UserAuthRepository>(
      UserAuthRepositoryImpl(userAuthRemoteDataSource: sl()));
  sl.registerSingleton<UserRepository>(
      UserRepositoryImpl(userRemoteDataSource: sl()));

  /// useCase
  // auth
  sl.registerSingleton<UserSignUpUsecase>(
    UserSignUpUsecase(userAuthRepository: sl()),
  );
  sl.registerSingleton<SendEmailVerificationUsecase>(
    SendEmailVerificationUsecase(userAuthRepository: sl()),
  );
  sl.registerSingleton<UserSignInUsecase>(
    UserSignInUsecase(userAuthRepository: sl()),
  );
  sl.registerSingleton<CheckEmailVerificationUsecase>(
    CheckEmailVerificationUsecase(userAuthRepository: sl()),
  );
  sl.registerSingleton<GetUserTypeUsecase>(
    GetUserTypeUsecase(userRepository: sl()),
  );
  sl.registerSingleton<GetAuthUserUsecase>(
    GetAuthUserUsecase(userAuthRepository: sl()),
  );
  sl.registerSingleton<UserSignOutUsecase>(
    UserSignOutUsecase(userAuthRepository: sl()),
  );
  sl.registerSingleton<ForgotPasswordUsecase>(
    ForgotPasswordUsecase(userAuthRepository: sl()),
  );
  sl.registerSingleton<RefreshUserUsecase>(
    RefreshUserUsecase(userAuthRepository: sl()),
  );

  // users
  sl.registerSingleton<GetAllUsersUsecase>(
    GetAllUsersUsecase(userRepository: sl()),
  );

  // user
  sl.registerSingleton<GetUserDetailsUsecase>(
    GetUserDetailsUsecase(userRepository: sl()),
  );

  /// bloc
  // auth
  sl.registerFactory<SignUpBloc>(
    () => SignUpBloc(
      sl(),
      sl(),
    ),
  );
  sl.registerFactory<SignInBloc>(
    () => SignInBloc(
      sl(),
      sl(),
      sl(),
    ),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );

  // users

  // user
}
