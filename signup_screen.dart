import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/screens/home/home_screen.dart';
import 'package:flutter_food_delivery_app/screens/login/login_screen.dart';
//import 'package:dropdown_formfield/dropdown_formfield.dart';

import 'package:flutter_food_delivery_app/widgets/reusable_widgets.dart';
import 'package:flutter_food_delivery_app/screens/color_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _confirmpasswordTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  final items = ['Restaurant', 'NGO'];
  String? value;
  String? holder = '';

  final _firestore = FirebaseFirestore.instance;

  @override
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("ffffff"),
          hexStringToColor("ebba86"),
          hexStringToColor("d70909")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Username", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Email", Icons.mail_outline, false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Password", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Confirm Password", Icons.lock_outline, true,
                    _confirmpasswordTextController),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  value: value,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.category_outlined,  color: Colors.white70,),
                        labelText: 'Category',
                        labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: Colors.black.withOpacity(0.3),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(width: 0, style: BorderStyle.none))

                    ),
                  items: items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => this.value = value),
                ),
                const SizedBox(
                  height: 20,
                ),
                logInSignUpButton(context, false, () {
                  setState(() {
                    holder = value;
                    print("$holder");
                  });
                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text,
                      password: _passwordTextController.text).then((value) async {
                    print("created new account");
                    await FirebaseFirestore.instance.collection('users').doc(value.user!.uid)
                        .set({
                      "username":_userNameTextController.text,
                      "email":_emailTextController.text,
                      "type":holder,
                    });

                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => LogInScreen()));
                      showAlertDialog(context, "Your account has been created.\n"
                          "Please LogIn");


                  }).onError((error, stackTrace)
                  {
                    print("ERROR ${error.toString()}");
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
