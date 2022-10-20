import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_chat/Controller/sign_in_provider.dart';
import 'package:hi_chat/Model/const.dart';
import 'package:hi_chat/Model/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignInSocial extends StatelessWidget {
  const SignInSocial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.keyboard_backspace,
                        color: kprimaryColor,
                      )),
                ),
                Center(
                  child: Column(children: [
                    Text(
                      'Let\'s you In',
                      style: GoogleFonts.montserrat(
                          color: kprimaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await signInWithGoogle(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/google-logo.png'),
                            const SizedBox(width: 5),
                            Text(
                              'Continue with Google',
                              style: GoogleFonts.montserrat(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        await signInWithFacebook(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/facebook-logo.png'),
                            const SizedBox(width: 5),
                            Text(
                              'Continue with Facebook',
                              style: GoogleFonts.montserrat(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(),
                        ),
                        Center(
                            child: Text(
                          ' or ',
                          style: GoogleFonts.montserrat(
                              backgroundColor: Colors.white),
                        ))
                      ],
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signInNumber');
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: kprimaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        width: double.infinity,
                        height: 60,
                        child: Center(
                          child: Text(
                            'Sign in with number',
                            style: GoogleFonts.montserrat(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    )
                  ]),
                ),
              ]),
        ),
      ),
    );
  }
}
