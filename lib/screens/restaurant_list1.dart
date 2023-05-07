import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/screens/restaurant_page.dart';
import 'package:flutter_food_delivery_app/screens/restaurantdetailsform.dart';
import 'package:flutter_food_delivery_app/screens/restauranttile.dart';
import 'package:flutter_food_delivery_app/models/restomodelerror.dart';

import '../models/category_model.dart';
import '../models/promo_model.dart';
import '../widgets/category_box.dart';
import '../widgets/promo_box.dart';
import 'account_info.dart';

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
      appBar: CustomAppBar(),

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
          final contact = resume['Contact'].toString();
          final vegNonveg = resume['vegNonveg'].toString();
          final Restaurant restaurant1=new Restaurant(id: count, name: name, address: address, item: item, quantity: quantity, contact: contact, vegNonveg: vegNonveg,);
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

  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.person, color: Colors.white),
        onPressed: () => {Navigator.push(context,
            MaterialPageRoute(builder: (context) => AccountInfo())),},
      ),
      backgroundColor: Colors.black,
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CURRENT LOCATION',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white,
            ),
          ),
          Text(
            'Navi Mumbai,India',
            style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
