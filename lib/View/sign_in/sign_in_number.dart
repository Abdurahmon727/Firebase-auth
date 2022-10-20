// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_chat/Controller/sign_in_provider.dart';
import 'package:hi_chat/Model/const.dart';
import 'package:hi_chat/Model/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignInNumber extends StatelessWidget {
  var controller = MaskedTextController(mask: '(00) 000 00 00');

  SignInNumber({super.key});

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
                      )),
                ),
                Center(
                  child: Column(children: [
                    Text(
                      'Sign in to your accound',
                      style: GoogleFonts.montserrat(
                          color: kprimaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: kprimaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: TextField(
                          autofocus: true,
                          controller: controller,
                          decoration: const InputDecoration(
                              prefix: Text(
                                '+998 ',
                                style: TextStyle(color: Colors.black),
                              ),
                              border: InputBorder.none,
                              hintText: '(90) 123 45 67'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            Provider.of<SignInProvider>(context, listen: false)
                                .setNumber(value);
                          },
                        )),
                    Visibility(
                        visible: Provider.of<SignInProvider>(context).isFail,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            Provider.of<SignInProvider>(context)
                                .exceptionNumber,
                            textAlign: TextAlign.left,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )),
                    GestureDetector(
                      onTap: () async {
                        if (Provider.of<SignInProvider>(context, listen: false)
                                .number
                                .length ==
                            14) {
                          await signInWithNumber(context).then((_) =>
                              Provider.of<SignInProvider>(context,
                                      listen: false)
                                  .setExceptionPhone(false, ''));
                        } else {
                          Provider.of<SignInProvider>(context, listen: false)
                              .setExceptionPhone(true, 'Invalid phone number');
                        }
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
                            'Log in',
                            style: GoogleFonts.montserrat(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ]),
        ),
      ),
    );
  }
}
