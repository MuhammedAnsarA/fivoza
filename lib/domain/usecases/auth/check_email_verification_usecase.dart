import 'package:dartz/dartz.dart';
import 'package:fivoza/core/error/failure.dart';
import 'package:fivoza/core/usecases/usecase.dart';
import 'package:fivoza/domain/repositories/auth/user_auth_repository.dart';

class CheckEmailVerificationUsecase extends UseCase<bool, NoParams> {
  final UserAuthRepository userAuthRepository;

  CheckEmailVerificationUsecase({required this.userAuthRepository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await userAuthRepository.checkEmailVerification();
  }
}
