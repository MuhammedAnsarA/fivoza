import 'package:dartz/dartz.dart';
import 'package:fivoza/core/error/failure.dart';
import 'package:fivoza/core/usecases/usecase.dart';
import 'package:fivoza/domain/repositories/auth/user_auth_repository.dart';

class ForgotPasswordUsecase extends UseCase<String, String> {
  final UserAuthRepository userAuthRepository;

  ForgotPasswordUsecase({required this.userAuthRepository});
  @override
  Future<Either<Failure, String>> call(String params) async {
    return await userAuthRepository.forgotPassword(params);
  }
}
