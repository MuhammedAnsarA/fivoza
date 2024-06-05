import 'package:dartz/dartz.dart';
import 'package:fivoza/core/error/failure.dart';
import 'package:fivoza/domain/entities/user/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> getUserType(String id);
  Future<Either<Failure, UserEntity>> getUserDetails();
  Future<Either<Failure, List<UserEntity>>> getAllUsers();
}
