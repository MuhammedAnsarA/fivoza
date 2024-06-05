import 'package:dartz/dartz.dart';
import 'package:fivoza/core/error/failure.dart';
import 'package:fivoza/core/usecases/usecase.dart';
import 'package:fivoza/domain/entities/user/user_entity.dart';
import 'package:fivoza/domain/repositories/user/user_repository.dart';

class GetAllUsersUsecase extends UseCase<List<UserEntity>, NoParams> {
  final UserRepository userRepository;

  GetAllUsersUsecase({required this.userRepository});
  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) async {
    return await userRepository.getAllUsers();
  }
}
