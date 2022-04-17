import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({Key? key}) : super(key: key);

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  final firestoreInstance=FirebaseFirestore.instance;



  @override
  Widget build(BuildContext context) {
    late String username = "";
    firestoreInstance.collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((result){
      username = (result.data()!["username"]);
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Hello, ${username}"  ,), //fetch username from firebase
      ),
    );
  }
}

