import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/screens/restaurantdetailsform.dart';
import 'package:flutter_food_delivery_app/screens/screens.dart';
import 'package:flutter_food_delivery_app/models/restomodelerror.dart' as prefix;

import '../models/models.dart';
import '../screens/restaurant_details1_screen.dart';
import '../screens/screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case LocationScreen.routeName:
        return LocationScreen.route();
      case FilterScreen.routeName:
        return FilterScreen.route();
      case RestaurantDetailsScreen.routeName:
        return RestaurantDetailsScreen.route(
            restaurant: settings.arguments as Restaurant);
      case RestaurantListingScreen.routeName:
        return RestaurantListingScreen.route(
            restaurants: settings.arguments as List<Restaurant>);
      case RestaurantDetailsScreen1.routeName:
        return RestaurantDetailsScreen1.route(
            restaurant: settings.arguments as prefix.Restaurant);
      //case RestaurantDetailsFormScreen.routeName:
        //return RestaurantDetailsFormScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong!'),
        ),
      ),
    );
  }
}
