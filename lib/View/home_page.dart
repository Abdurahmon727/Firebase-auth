// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_chat/Model/const.dart';
import 'package:hi_chat/View/drawer.dart';

class HomePage extends StatelessWidget {
  List<Map<String, dynamic>> firestoreData = [];

  Future<void> readData() async {
    await FirebaseFirestore.instance.collection('operators').get().then((db) {
      for (var doc in db.docs) {
        firestoreData.add(doc.data());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(child: myDrawer(context)),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: kprimaryColor,
        title: Text(
          'HiChat',
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: ListView.builder(
        itemCount: firestoreData.length,
        itemBuilder: (context, index) => ListTile(
          title: firestoreData[index]['name'],
        ),
      ),
    );
  }
}
