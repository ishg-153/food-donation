import 'package:equatable/equatable.dart';

import 'menu_item_model.dart';

class Restaurant extends Equatable {
  final int id;
  final String name;
  final String item;
  final String quantity;
  final String address;
  final String contact;
  final String vegNonveg;



  const Restaurant({
    required this.id,
    required this.name,
    required this.item,
    required this.quantity,
    required this.address,
    required this.contact,
    required this.vegNonveg,

  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      item,address,quantity, vegNonveg,
    ];
  }


}