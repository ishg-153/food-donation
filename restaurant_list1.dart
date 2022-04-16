import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/screens/restaurant_page.dart';
import 'package:flutter_food_delivery_app/screens/restauranttile.dart';
import 'package:flutter_food_delivery_app/models/restomodelerror.dart';

//import '../listtile.dart';

final _fireStore = FirebaseFirestore.instance;

class ResumeList extends StatefulWidget {
  const ResumeList({Key? key}) : super(key: key);

  @override
  _ResumeListState createState() => _ResumeListState();
}

class _ResumeListState extends State<ResumeList> {
  /*List<ListWidget> resumeList = [
    const ListWidget(
        name: 'Tejas Shelke',
        email: 'tejas@gmail.com',
        year: 'Third Year, Computer Engineering'),
    const ListWidget(
        name: 'Darshan Rao',
        email: 'darshan@gmail.com',
        year: 'Third Year, Computer Engineering')
  ];*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurants"),
        backgroundColor: Colors.green,
      ),
      body: ResumeStream(),
    );
  }
}

class ResumeStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('restaurant_details').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        final resumes = snapshot.data!.docs;
        print(resumes);
        List<GestureDetector> resumeListWidgets = [];
        int count=0;

        for (var resume in resumes) {



          count=count+1;
          final name = resume['Name'].toString();
          final address = resume['Address'].toString();
          final item = resume['Item'].toString();
          final quantity = resume['Quantity'].toString();
          final vegNonveg=resume['vegNonveg'].toString();
          final contact = resume['Contact'].toString();

          final user=_fireStore.collection('users').doc(resume['User'].toString()).get().then((result){
            return (result.data()!["username"]);

            //print(usertype);
    });

          //final user=us;

          final Restaurant restaurant1=new Restaurant(id: count, name: name, address: address, item: item, quantity: quantity,vegNonveg: vegNonveg,contact:contact,user:user,);
          final List<Restaurant> restaurants1=[];
          restaurants1.add(restaurant1);
          final resumeListWidget = GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResumePage(
                       restaurants: [restaurant1],
                      )));
            },
            child: ListWidget(
              restaurant:restaurant1,
            ),
          );
          resumeListWidgets.add(resumeListWidget);
        }
        return ListView(
          children: resumeListWidgets,
        );
      },
    );
    ;
  }
}
