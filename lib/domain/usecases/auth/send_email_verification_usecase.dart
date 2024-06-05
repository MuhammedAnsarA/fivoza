import 'package:dartz/dartz.dart';
import 'package:fivoza/core/error/failure.dart';
import 'package:fivoza/core/usecases/usecase.dart';
import 'package:fivoza/domain/repositories/auth/user_auth_repository.dart';

class SendEmailVerificationUsecase extends UseCase<String, NoParams> {
  final UserAuthRepository userAuthRepository;

  SendEmailVerificationUsecase({required this.userAuthRepository});
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await userAuthRepository.sendEmailVerification();
  }
}
