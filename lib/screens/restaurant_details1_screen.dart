import 'package:flutter/material.dart';

//import '../../models/models.dart';
import '../../models/restomodelerror.dart';
import '../../widgets/widgets.dart';
//import 'pa';

class RestaurantDetailsScreen1 extends StatelessWidget {
  static const String routeName = '/restaurant-details1';

  static Route route({required Restaurant restaurant}) {
    return MaterialPageRoute(
      builder: (_) => RestaurantDetailsScreen1(restaurant: restaurant),
      settings: RouteSettings(name: routeName),
    );
  }

  final Restaurant restaurant;

  const RestaurantDetailsScreen1({
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      //bottomNavigationBar: CustomBottomAppBar(text: 'Basket'),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 100, 20, 10),

                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),


              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text('Address\n${restaurant.address}\n\nContact at ${restaurant.contact}\n\nItem: ${restaurant.item}\nQuantity: ${restaurant.quantity}\nVeg/Non-Veg: ${restaurant.vegNonveg}',style: TextStyle(color: Colors.black,fontSize: 18)),),





            ]
        ),
      ),
    );
  }
}