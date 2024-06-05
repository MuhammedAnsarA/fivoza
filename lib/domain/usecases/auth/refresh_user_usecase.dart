import 'package:firebase_auth/firebase_auth.dart';
import 'package:fivoza/domain/repositories/auth/user_auth_repository.dart';

class RefreshUserUsecase {
  final UserAuthRepository userAuthRepository;

  RefreshUserUsecase({required this.userAuthRepository});

  Future<User?> refreshUserCall(User? params) async {
    return await userAuthRepository.refreshUser(params);
  }
}
