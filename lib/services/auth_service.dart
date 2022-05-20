import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared/string_texts.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  String getUserID(){
    usuario = _auth.currentUser;
    return usuario!.uid.toString();
  }

  String getUserEmail() {
    usuario = _auth.currentUser;
    return usuario!.email.toString();
  }

  saveUserOffline(String nome, String email, String urlPic, String id) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString('user-name', nome);
      await prefs.setString('user-email', email);
      await prefs.setString('user-pic', urlPic);
      await prefs.setString('user-id', id);
    } on Exception catch (_) {
      throw("Error on Saving Data");
    }
  }

  removeUserOffline() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.remove('user-name');
      await prefs.remove('user-email');
      await prefs.remove('user-pic');
      await prefs.remove('user-id');
    } on Exception catch (_) {
      throw("Error on Saving Data");
    }
  }

  registrar(String email, String senha, String nome) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      users
          .doc(email)
          .set({'id' : getUserID(), 'name': nome, 'email': email})
          .then((_) => print('User $nome created'))
          .catchError((error) => print('Add failed: $error'));
      User? user = _auth.currentUser;
      user?.updateDisplayName(nome.toString());
      _getUser();
      saveUserOffline(nome, email, user?.photoURL ?? "", user?.uid ?? "");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException(weakPassText);
      } else if (e.code == 'email-already-in-use') {
        throw AuthException(emailAlrExistsText);
      }
    }
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
      User? user = _auth.currentUser;
      saveUserOffline(user?.displayName ?? "", email, user?.photoURL ?? "", user?.uid ?? "");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException(emailNotFndText);
      } else if (e.code == 'wrong-password') {
        throw AuthException(wrongPassText);
      }
    }
  }

  Future<String?> signInwithGoogle() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
      User? user = _auth.currentUser;
      users
          .doc(user?.email)
          .set({'id' : getUserID(), 'name': user?.displayName, 'email': user?.email})
          .catchError((error) => print('Add failed: $error'));
      user?.updateDisplayName(user.displayName.toString());
      _getUser();
      saveUserOffline(user?.displayName ?? "", user?.email ?? "", user?.photoURL ?? "", user?.uid ?? "");
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    removeUserOffline();
    _getUser();
  }
}