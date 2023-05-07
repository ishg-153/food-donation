import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/screens/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_food_delivery_app/screens/login/login_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_food_delivery_app/widgets/reusable_widgets.dart';
import 'package:flutter_food_delivery_app/screens/color_utils.dart';

class RestaurantDetailsFormScreen extends StatefulWidget {
  const RestaurantDetailsFormScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantDetailsFormScreen> createState() =>
      _RestaurantDetailsFormScreenState();
}

class _RestaurantDetailsFormScreenState
    extends State<RestaurantDetailsFormScreen> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();
  TextEditingController _itemTextController = TextEditingController();
  TextEditingController _quantityTextController = TextEditingController();
  TextEditingController _categoryTextController = TextEditingController();
  final _ref = FirebaseDatabase.instance.ref();
  final _firestore = FirebaseFirestore.instance;

  final items = ['Veg', 'Non-veg'];
  String? value;
  String? holder = '';

  @override
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: TextStyle(color: Colors.white,),
    ),
  );
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white38,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Enter listing details",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        /*decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),*/
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Organization Name", Icons.person_outline,
                    false, _nameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Address", Icons.food_bank_outlined, false,
                    _addressTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Contact Number", Icons.phone, false,
                    _phoneTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Food item/s", Icons.restaurant, false,
                    _itemTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Serving", Icons.rice_bowl_outlined, false,
                    _quantityTextController),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  value: value,
                  dropdownColor: Colors.black,
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
                ElevatedButton(
                  onPressed: () {
                    //onTap();
                    holder = value;
                    _firestore.collection('restaurant_details').add({
                      'Name': _nameTextController.text,
                      'Address': _addressTextController.text,
                      'Contact': _phoneTextController.text,
                      'Item': _itemTextController.text,
                      'Quantity': _quantityTextController.text,
                      'vegNonveg': holder,
                      'User': FirebaseAuth.instance.currentUser?.uid,
                    });

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                    showAlertDialog(context, "Your listing has been posted.", "Success");
                  },
                  child: Text(
                    'Post',
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black26;
                        }
                        return Colors.white;
                      }),
                      minimumSize: MaterialStateProperty.all<Size>(Size(100, 50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)))),
                ),

                //child: const Text("Submit");
                // FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text,
                //     password: _passwordTextController.text).then((value) {
                //   print("created new account");
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => HomeScreen()));
                // }).onError((error, stackTrace)
                // {
                //   print("ERROR ${error.toString()}");
                // });
                //}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
