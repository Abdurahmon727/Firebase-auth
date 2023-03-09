import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Model/const.dart';

Drawer myDrawer(BuildContext context) => Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 160,
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const CircleAvatar(
                          backgroundColor: kprimaryColor,
                          radius: 50,
                        ),
                        InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    'Joriy hisobdan chiqish',
                                    style: GoogleFonts.montserrat(),
                                  ),
                                  content: Text(
                                    'Rostan ham joriy hisobdan chiqmoqchimisiz?',
                                    style: GoogleFonts.montserrat(),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Bekor qilish',
                                          style: GoogleFonts.montserrat(),
                                        )),
                                    TextButton(
                                        onPressed: () async {
                                          await FirebaseAuth.instance
                                              .signOut()
                                              .then((_) {
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/welcomePage',
                                                (route) => false);
                                          });
                                        },
                                        child: Text(
                                          'Chiqish',
                                          style: GoogleFonts.montserrat(
                                              color: kprimaryColor),
                                        )),
                                  ],
                                ),
                              );
                            },
                            child: const SizedBox(
                                height: 40,
                                width: 40,
                                child: Icon(Icons.logout_outlined)))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      FirebaseAuth.instance.currentUser?.email ?? '',
                      style: GoogleFonts.montserrat(fontSize: 15),
                    ),
                    Text(
                      '+998 90 000 00 00',
                      style: GoogleFonts.montserrat(color: Colors.grey),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
