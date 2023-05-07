import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/models/models.dart';

class CategoryBox extends StatelessWidget {
  final Category category;

  const CategoryBox({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Restaurant> restaurants = Restaurant.restaurants
        .where((restaurant) => restaurant.vegNonVeg==(category.name))
        .toList();

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/restaurant-listing',
            arguments: restaurants);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15.0),
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          //color: Theme.of(context).primaryColorLight,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                height: 30,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  //color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: -1,
              left: 10,

              child: category.image, width: 50, height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  category.name,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
