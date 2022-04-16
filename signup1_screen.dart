import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/screens/home/home_screen.dart';
import 'package:flutter_food_delivery_app/screens/login/login_screen.dart';
//import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_food_delivery_app/widgets/reusable_widgets.dart';
import 'package:flutter_food_delivery_app/screens/color_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  final items =  ['Restaurant','NGO'];
  String? value;
  String? holder = '' ;
  //TextEditingController _usernameTextController = TextEditingController();
  //TextEditingController _emailTextController = TextEditingController();
  //TextEditingController _typeTextController = TextEditingController();
  //TextEditingController _quantityTextController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  //FirebaseAuth user=FirebaseAuth.instance().getCurrentUser();
  //FirebaseUser user=FirebaseAuth.getInstance().getCurrentUser();
  @override
  DropdownMenuItem<String> buildMenuItem(String item)=>
      DropdownMenuItem(
        value:item,
        child:Text(
          item,
        ),
      );
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                reusableTextField("Enter Username", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.person_outline, false,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),

                DropdownButton<String>(
                  value:value,
                  items:items.map(buildMenuItem).toList(),
                  onChanged: (value)=>setState(()=>this.value=value),


                ),

                const SizedBox(
                  height: 20,
                ),




                logInSignUpButton(context, false, () {
                  setState(() {
                    holder = value ;
                    print("$holder");
                  });
                  //const {username,email,type}=users

                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text,
                      password: _passwordTextController.text).then((value) async {
                        print("created new account");
                        await FirebaseFirestore.instance.collection('users').doc(value.user!.uid)
                            .set({
                          "username":_userNameTextController.text,
                          "email":_emailTextController.text,
                          "type":holder,
                        });
                        /*_firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid)
                        .set({
                          username:_userNameTextController,
                          email:_emailTextController,
                          type:holder,
                        })*//*_firestore.collection('users').add({
                          'username': _userNameTextController.text,
                          'email': _emailTextController.text,
                          'type': holder,

                        });*/
                        if(holder=='Restaurant') {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        }
                        else{
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => LogInScreen()));
                        }
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
