import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/models/restomodelerror.dart';
import 'package:flutter_food_delivery_app/screens/restauranttile.dart';

class ResumePage extends StatelessWidget {
  final List<Restaurant> restaurants;
  ResumePage({required this.restaurants,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Listings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return ListWidget(
              restaurant: restaurants[index],
            );
          },
        ),
      ),
    );
  }
}
