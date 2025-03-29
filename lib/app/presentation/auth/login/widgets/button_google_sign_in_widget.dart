import 'package:enxoval_baby/app/core/utils/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ButtonGoogleSignInWidget extends StatefulWidget {
  const ButtonGoogleSignInWidget({super.key});

  @override
  State<ButtonGoogleSignInWidget> createState() =>
      _ButtonGoogleSignInWidgetState();
}

class _ButtonGoogleSignInWidgetState extends State<ButtonGoogleSignInWidget> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: IconButton(
        icon: Image.asset(
          height: 50,
          ImageIconsPaths.googleLogo.path,
        ),
        onPressed: () async {
          final googleUser = await _googleSignIn.signIn();
          if (googleUser != null) print(googleUser.email);
        },
      ),
    );
  }
}
