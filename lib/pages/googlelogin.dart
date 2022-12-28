import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:moneylover/refactor/snackbar.dart';
import 'package:moneylover/router/router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Google_login {
  saveuid(uid) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("uid", uid);
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> googlesignin(BuildContext context) async {
    EasyLoading.show(status: 'Please Wait..');
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      EasyLoading.dismiss();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication.whenComplete(() {
        EasyLoading.show(status: 'Please Wait..');
      });
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      if (result.user != null) {
        EasyLoading.dismiss();
        String? mail = result.user!.email;
        User user = result.user!;
        saveuid(user.uid);

        ("HELLO000000 $mail");

        CustomSnackBar(context, const Text('Login Successfully'), Colors.green);
        context.router.push(const AuthFlowRoute());
      }

// if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }
}
