import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/models/user.dart';


class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj base on FirebaseUser(User)
  UserApp? _userFromFirebaseUser(User? user){
    return user != null ? UserApp(uid: user.uid) : null;
  }
  
  // auth change user stream
  Stream<UserApp?> get user {
    return _auth.authStateChanges().map((event) => _userFromFirebaseUser(event));
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;

    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      
      //create a new doc for the  user uid
      await DatabaseService(uid: user!.uid).updateUserData('0', 'new crew member', 100);

      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      return null;
    }
  } 

}