import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fivoza/core/constants/strings.dart';
import 'package:fivoza/core/error/exception.dart';
import 'package:fivoza/core/utils/enum.dart';
import 'package:fivoza/core/utils/extension.dart';
import 'package:fivoza/data/model/user/user_model.dart';
import 'package:fivoza/domain/usecases/auth/sign_in_params.dart';
import 'package:fivoza/domain/usecases/auth/sign_up_params.dart';

abstract class UserAuthRemoteDataSource {
  Future<String> signInUser(SignInParams signInParams);
  Future<String> signUpUser(SignUpParams signUpParams);
  Future<String> sendEmailVerification();
  Future<bool> checkEmailVerification();
  Stream<User?> get user;
  Future<String> signOutUser();
  Future<String> forgotPassword(String email);
  Future<User?> refreshUser(User user);
}

class UserAuthRemoteDataSourceImpl implements UserAuthRemoteDataSource {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;

  UserAuthRemoteDataSourceImpl({
    required this.fireStore,
    required this.auth,
  });
  @override
  Future<bool> checkEmailVerification() async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        return await Future.value(auth.currentUser!.emailVerified);
      } else {
        return await Future.value(false);
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException(errorMessage: e.toString());
    }
  }

  @override
  Future<String> forgotPassword(String email) async {
    try {
      final result = await fireStore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (result.docs.length == 1) {
        await auth.sendPasswordResetEmail(email: email);
        return ResponseTypes.success.response;
      } else {
        return ResponseTypes.failure.response;
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException(errorMessage: e.toString());
    }
  }

  @override
  Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await user.reload();
    User? refreshedUser = auth.currentUser;
    return refreshedUser;
  }

  @override
  Future<String> sendEmailVerification() async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        await auth.currentUser?.sendEmailVerification();
        return ResponseTypes.success.response;
      } else {
        return ResponseTypes.failure.response;
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException(errorMessage: e.toString());
    }
  }

  @override
  Future<String> signInUser(SignInParams signInParams) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: signInParams.email, password: signInParams.password);
      auth.currentUser!.reload();
      return auth.currentUser!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw AuthException(errorMessage: AppStrings.invalidEmail);
      }
      if (e.code == 'user-not-found') {
        throw AuthException(errorMessage: AppStrings.userNotFound);
      }
      if (e.code == 'wrong-password') {
        throw AuthException(errorMessage: AppStrings.wrongPassword);
      }
      if (e.code == 'invalid-credential') {
        throw AuthException(errorMessage: AppStrings.invalidCredential);
      } else {
        throw AuthException(errorMessage: e.toString());
      }
    }
  }

  @override
  Future<String> signOutUser() async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        await auth.signOut();
        return ResponseTypes.success.response;
      } else {
        return ResponseTypes.failure.response;
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException(errorMessage: e.toString());
    }
  }

  @override
  Future<String> signUpUser(SignUpParams signUpParams) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: signUpParams.email, password: signUpParams.password);

      UserModel userAuthModel = UserModel(
          userId: credential.user!.uid,
          userType: 'user',
          userName: signUpParams.userName,
          email: signUpParams.email,
          password: signUpParams.password);

      await fireStore
          .collection('users')
          .doc(credential.user!.uid)
          .set(userAuthModel.toJson());

      await fireStore
          .collection('cart')
          .doc(credential.user!.uid)
          .set({'ids': []});

      return ResponseTypes.success.response;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException(errorMessage: AppStrings.weakPassword);
      } else if (e.code == 'email-already-in-use') {
        throw AuthException(errorMessage: AppStrings.emailAlreadyUsed);
      } else if (e.code == 'invalid-email') {
        throw AuthException(errorMessage: AppStrings.invalidEmail);
      } else {
        throw AuthException(errorMessage: e.toString());
      }
    }
  }

  @override
  Stream<User?> get user => auth.authStateChanges().map((authUser) => authUser);
}
