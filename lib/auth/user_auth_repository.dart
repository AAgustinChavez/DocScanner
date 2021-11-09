import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuthRepository extends ChangeNotifier{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isAlreadyLogged(){
    var user = _auth.currentUser;
    print("User: ${user?.displayName}");
    return user != null;
  }

  Future<void> signOutGoogle()async{
    await _googleSignIn.signOut();
  }

  Future<void> signOutFirebase()async{
    await _auth.signOut();
  }

  Future<void> signInWithGoogle()async{
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;

    print("User: ${googleUser.displayName}");
    print("User: ${googleUser.email}");
    print("User: ${googleUser.photoUrl}");

    //credenciales para firebase
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //firebase sign in
    final authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user!;
    final firebaseToken = await user.getIdToken();
    assert(!user.isAnonymous);
    // ignore: unnecessary_null_comparison
    assert(firebaseToken!=null);
    final User currentUser = _auth.currentUser!;
    assert(user.uid == currentUser.uid);

    print("Firebase Token: $firebaseToken");
    notifyListeners();
  }

}