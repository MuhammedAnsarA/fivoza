import 'package:dartz/dartz.dart';
import 'package:fivoza/core/error/exception.dart';
import 'package:fivoza/core/error/failure.dart';
import 'package:fivoza/data/data_sources/remote/user/user_remote_data_source.dart';
import 'package:fivoza/domain/entities/user/user_entity.dart';
import 'package:fivoza/domain/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({required this.userRemoteDataSource});
  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      final result = await userRemoteDataSource.getAllUsers();
      return Right(result);
    } on DBException catch (e) {
      return Left(FirebaseFailure(errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserDetails() async {
    try {
      final result = await userRemoteDataSource.getUserDetails();
      return Right(result);
    } on DBException catch (e) {
      return Left(FirebaseFailure(errorMessage: e.errorMessage));
    } on AuthException catch (e) {
      return Left(FirebaseFailure(errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, String>> getUserType(String id) async {
    try {
      final result = await userRemoteDataSource.getUserType(id);
      return Right(result);
    } on AuthException catch (e) {
      return Left(FirebaseFailure(errorMessage: e.errorMessage));
    }
  }
}
