import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<FirebaseUser> onAuthChanged() {
    return _firebaseAuth.onAuthStateChanged;
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signInWithGoogle() async {
    await _googleSignIn.signOut();
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.getCredential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    await _firebaseAuth.signInWithCredential(authCredential);
    await _firebaseAuth.currentUser();
  }

  Future<void> signUp(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
    return firebaseUser;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

//  Future<bool> isSignedIn() async {
//    final currentUser = await _firebaseAuth.currentUser();
//    return currentUser != null;
//  }

//  Future<String> getAccessToken() async {
//    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
//    IdTokenResult idTokenResult = await firebaseUser.getIdToken();
//
//    return idTokenResult.token;
//  }
//
//  Future<String> getRefreshToken() async {
//    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
//    IdTokenResult idTokenResult = await firebaseUser.getIdToken(refresh: true);
//
//    return idTokenResult.token;
//  }

//  Future<void> sendEmailVerification() async {
//    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
//    firebaseUser.sendEmailVerification();
//  }
//
//  Future<bool> isEmailVerified() async {
//    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
//    return firebaseUser.isEmailVerified;
//  }

//  Future<void> changeEmail(String email) async {
//    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
//    return firebaseUser.updateEmail(email);
//  }
//
//  Future<void> changePassword(String password) async {
//    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
//    firebaseUser
//        .updatePassword(password)
//        .then((_) => print("Successfully changed password"))
//        .catchError((onError) {
//      print("Password can't be changed" + onError.toString());
//    });
//  }

//  Future<void> deleteUser() async {
//    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
//    firebaseUser
//        .delete()
//        .then((_) => print("Successfully user deleted"))
//        .catchError((onError) {
//      print("User can't be deleted" + onError.toString());
//    });
//  }
//
//  Future<void> sendPasswordResetEmail(String email) async {
//    await _firebaseAuth.sendPasswordResetEmail(email: email);
//  }
}
