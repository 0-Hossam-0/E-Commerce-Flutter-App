import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/ui/Screens/Home/home.dart';
import 'package:e_commerce/ui/Screens/Login/login.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle(BuildContext context) async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    final googleAuth = await googleUser.authentication;
    final cred = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    UserCredential userCredential = await _auth.signInWithCredential(cred);
    User? user = userCredential.user;
    if (user != null) {
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('Users').doc(user.uid);
      DocumentSnapshot docSnapshot = await userDoc.get();
      if (!docSnapshot.exists) {
        await userDoc.set({
          'username': user.displayName,
          'email': user.email,
          'photoUrl': user.photoURL,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status != LoginStatus.success) {
      return;
    }
    final accessToken = loginResult.accessToken;
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(accessToken!.token);
    UserCredential userCredential =
        await _auth.signInWithCredential(facebookAuthCredential);
    User? user = userCredential.user;
    if (user != null) {
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('Users').doc(user.uid);
      DocumentSnapshot docSnapshot = await userDoc.get();
      if (!docSnapshot.exists) {
        await userDoc.set({
          'username': user.displayName,
          'email': user.email,
          'photoUrl': user.photoURL,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> signOut(context) async {
    try {
      await _auth.signOut();
    } catch (e) {
      ElegantNotification.error(
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: 80,
        position: Alignment.topRight,
        animation: AnimationType.fromRight,
        title: const Text('Error'),
        description: Text('Something went wrong!'),
      ).show(context);
    }
  }

  Future<void> signIn(
      {required String email,
      required String password,
      required context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false,
      );
      ElegantNotification.success(
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: 80,
        position: Alignment.topRight,
        animation: AnimationType.fromRight,
        title: const Text('Succuss'),
        description: Text('Logged in Succufully'),
      ).show(context);
    } catch (e) {
      ElegantNotification.error(
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: 80,
        position: Alignment.topRight,
        animation: AnimationType.fromRight,
        title: const Text('Error'),
        description: Text('Email or Password is Wrong!'),
      ).show(context);
    }
  }

  Future<void> signUp(
      {required String username,
      required String email,
      required String password,
      required context}) async {
    String message = '';
    int messageType = 0;
    IconData icon = Icons.password;
    try {
      UserCredential authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = authResult.user!.uid;
      await FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'email': email,
        'username': username,
        'createdAt': FieldValue.serverTimestamp(),
      });
      message = 'Account Created Succufully';
      messageType = 1;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
        messageType = 2;
        icon = Icons.password;
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
        messageType = 2;
        icon = Icons.account_circle_rounded;
      } else {
        message = 'The email address is badly formatted.';
        messageType = 2;
        icon = Icons.mail;
      }
    }
    switch (messageType) {
      case 1:
        ElegantNotification.success(
          width: MediaQuery.sizeOf(context).width * 0.9,
          height: 80,
          position: Alignment.topRight,
          animation: AnimationType.fromRight,
          title: const Text('Succuss'),
          description: Text(message),
        ).show(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
      case 2:
        ElegantNotification.error(
          width: MediaQuery.sizeOf(context).width * 0.9,
          height: 80,
          icon: Icon(icon),
          position: Alignment.topRight,
          animation: AnimationType.fromRight,
          title: const Text('Error'),
          description: Text(message),
        ).show(context);
    }
  }
}
