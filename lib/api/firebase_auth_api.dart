import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  User? getUser() {
    // gets the signed-in user
    return auth.currentUser;
  }

  Stream<User?> userSignedIn() {
    // checks if someone is signed in
    return auth.authStateChanges();
  }

  Future<void> signUp(String email, String password) async {
    UserCredential credential;

    try {
      credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print("Error: email already exists!");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String?> signIn(String email, String password) async {
    UserCredential credential;

    try {
      credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Signed in!";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
