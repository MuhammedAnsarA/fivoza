import 'package:dartz/dartz.dart';
import 'package:fivoza/core/error/failure.dart';
import 'package:fivoza/core/usecases/usecase.dart';
import 'package:fivoza/domain/repositories/user/user_repository.dart';

class GetUserTypeUsecase extends UseCase<String, String> {
  final UserRepository userRepository;

  GetUserTypeUsecase({required this.userRepository});
  @override
  Future<Either<Failure, String>> call(String params) async {
    return await userRepository.getUserType(params);
  }
}
