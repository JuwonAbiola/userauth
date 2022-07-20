import 'package:firebase_auth/firebase_auth.dart';
import 'package:userauth/modules/auth/models/login_model.dart';
import 'package:userauth/modules/auth/models/signup_model.dart';

class AuthService {
  static Future<User?> signUp({
    required SignUpModel signupModel,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: signupModel.email ?? '',
        password: signupModel.password ?? '',
      );
      user = userCredential.user;
      await user!.updateDisplayName(signupModel.name);
      await user.reload();
      await user.sendEmailVerification();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'unknown error';
    } catch (e) {
      throw e.toString();
    }

    return user;
  }

  static Future<User?> login({
    required LoginModel loginModel,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: loginModel.email ?? '',
        password: loginModel.password ?? '',
      );
      user = userCredential.user;
      if (!user!.emailVerified) {
        await user.sendEmailVerification();
        throw 'An email has been sent to you. please verify your email';
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'unknown error';
    } catch (e) {
      throw e.toString();
    }

    return user;
  }
}
