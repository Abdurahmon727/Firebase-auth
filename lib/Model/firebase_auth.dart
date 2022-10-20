// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hi_chat/Controller/sign_in_provider.dart';
import 'package:provider/provider.dart';

import '../Controller/is_signed.dart';

//Google Sign in
Future<void> signInWithGoogle(BuildContext context) async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  try {
    await FirebaseAuth.instance.signInWithCredential(credential).then((_) {
      Navigator.pushNamedAndRemoveUntil(context, '/homePage', (route) => false);
    });
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 5),
        content: Text(
          e.message.toString(),
          style: const TextStyle(color: Colors.red),
        )));
  }
}

//Facebook sign in
Future<void> signInWithFacebook(BuildContext context) async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();
  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //sign in
  try {
    FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential)
        .then((_) {});
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 5),
        content: Text(
          e.toString(),
          style: const TextStyle(color: Colors.red),
        )));
  }
}

//Phone number sign in
String id = '';
Future<void> signInWithNumber(BuildContext context) async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber:
        '+998 ${Provider.of<SignInProvider>(context, listen: false).number}',
    verificationCompleted: (PhoneAuthCredential credential) async {
      await FirebaseAuth.instance.signInWithCredential(credential).then((_) =>
          Navigator.pushNamedAndRemoveUntil(
              context, '/homePage', (route) => false));
    },
    verificationFailed: (FirebaseAuthException e) {
      Provider.of<SignInProvider>(context, listen: false)
          .setExceptionPhone(true, e.message ?? '');
    },
    codeSent: (String verificationId, int? resendToken) async {
      id = verificationId;
      Navigator.pushNamed(context, '/smsCheck');
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}

void checkSms(BuildContext context) async {
  if (Provider.of<SignInProvider>(context, listen: false).smsCode.length == 6) {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: id,
          smsCode: Provider.of<SignInProvider>(context, listen: false).smsCode);
      await FirebaseAuth.instance.signInWithCredential(credential).then((_) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/homePage', (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      Provider.of<SignInProvider>(context, listen: false)
          .setExceptionSms(true, e.message.toString());
    }
  } else {
    Provider.of<SignInProvider>(context, listen: false)
        .setExceptionSms(true, 'Too short sms code :(');
  }
}
