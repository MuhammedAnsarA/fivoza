import 'package:dartz/dartz.dart';
import 'package:fivoza/core/error/failure.dart';
import 'package:fivoza/core/usecases/usecase.dart';
import 'package:fivoza/domain/repositories/auth/user_auth_repository.dart';
import 'package:fivoza/domain/usecases/auth/sign_in_params.dart';

class UserSignInUsecase extends UseCase<String, SignInParams> {
  final UserAuthRepository userAuthRepository;

  UserSignInUsecase({required this.userAuthRepository});
  @override
  Future<Either<Failure, String>> call(SignInParams params) async {
    return await userAuthRepository.signInUser(params);
  }
}
