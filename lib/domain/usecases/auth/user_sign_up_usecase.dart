import 'package:dartz/dartz.dart';
import 'package:fivoza/core/error/failure.dart';
import 'package:fivoza/core/usecases/usecase.dart';
import 'package:fivoza/domain/repositories/auth/user_auth_repository.dart';
import 'package:fivoza/domain/usecases/auth/sign_up_params.dart';

class UserSignUpUsecase extends UseCase<String, SignUpParams> {
  final UserAuthRepository userAuthRepository;

  UserSignUpUsecase({required this.userAuthRepository});

  @override
  Future<Either<Failure, String>> call(SignUpParams params) async {
    return await userAuthRepository.signUpUser(params);
  }
}
