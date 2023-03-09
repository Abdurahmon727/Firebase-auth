import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Controller/sign_in_provider.dart';
import '../../Model/const.dart';
import '../../Model/firebase_auth.dart';

class SmsChechPage extends StatelessWidget {
  final controller = MaskedTextController(mask: '000000');

  SmsChechPage({super.key});
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
                      'Enter Sms code',
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
                          controller: controller,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'sms code'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            Provider.of<SignInProvider>(context, listen: false)
                                .setSmsCode(value);
                          },
                        )),
                    Visibility(
                        visible: Provider.of<SignInProvider>(context).isFailSms,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            Provider.of<SignInProvider>(context).exceptionSms,
                            textAlign: TextAlign.left,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )),
                    GestureDetector(
                      onTap: () {
                        checkSms(context);
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
                            'Sign in',
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
