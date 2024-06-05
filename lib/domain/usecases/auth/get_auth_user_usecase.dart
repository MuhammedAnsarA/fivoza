import 'package:firebase_auth/firebase_auth.dart';
import 'package:fivoza/domain/repositories/auth/user_auth_repository.dart';

class GetAuthUserUsecase {
  final UserAuthRepository userAuthRepository;

  GetAuthUserUsecase({required this.userAuthRepository});

  Stream<User?> get user {
    return userAuthRepository.user;
  }
}
