import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/screens/restaurant_list1.dart';
import 'package:flutter_food_delivery_app/screens/signup/signup_screen.dart';
import 'package:flutter_food_delivery_app/screens/color_utils.dart';

import 'package:flutter_food_delivery_app/widgets/reusable_widgets.dart';
import '../home/home_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => LogInScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  final firestoreInstance=FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: (BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("ffffff"),
            hexStringToColor("ebba86"),
            hexStringToColor("d70909"),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        )),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/logo1.png"),
                SizedBox(
                  height: 30,
                ),
                reusableTextField("Email", Icons.person_outline, false,
                    _emailTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Password", Icons.lock_outline, true,
                    _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                logInSignUpButton(context, true, () {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text).then((value){
                    //FirebaseFirestore.instance.collection('users').where('email',isEqualTo: _emailTextController.text).get().then((DocumentSnapshot documentSnapsot){
                    // print(result);
                    // });
                    firestoreInstance.collection('users')
                        .doc(value.user!.uid)
                        .get()
                        .then((result){
                      var usertype=(result.data()!["type"]);

                      print(usertype);
                      if(usertype=='Restaurant')
                      {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomeScreen()));
                      }
                      else
                      {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ResumeList()));
                      }

                    });

                  }).onError((error, stackTrace){
                    print("error ${error.toString()}");
                  });

                }),
                signUpOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",
            style: TextStyle(color: Colors.white70, fontSize: 15)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "  Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        )
      ],
    );
  }
}