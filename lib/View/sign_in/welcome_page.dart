import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Model/const.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          } else if (snapshot.hasData) {
            return Stack(children: [
              Align(
                  alignment: const Alignment(0, -0.75),
                  child: Image.asset('assets/welcome.png')),
              Align(
                alignment: const Alignment(0, 1),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Welcome to HiChat!',
                        style: GoogleFonts.montserrat(
                            color: kprimaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'The best messenger and chat app of the century to make your day great!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signInSocial');
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: kprimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          width: double.infinity,
                          height: 60,
                          child: Center(
                            child: Text(
                              'Get Started',
                              style:
                                  GoogleFonts.montserrat(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              )
            ]);
          } else {
            return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}
