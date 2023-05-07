import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final Image image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [name, image];

  static List<Category> categories = [
    Category(
      id: 1,
      name: 'Veg',
      image: Image.asset(
        'assets/1.png',
      ),
    ),
    Category(
      id: 2,
      name: 'NonVeg',
      image: Image.asset(
        'assets/2.png',
      ),
    ),

  ];
}
