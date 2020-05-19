import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moPass/components/dish_tile.dart';
import 'package:moPass/models/dish.dart';

class MenuItemPage extends StatelessWidget {
  final List<Dish> dishes;

  MenuItemPage(this.dishes);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 23.0, left: 15.0, right: 15.0),
        child: ListView.builder(
          itemCount: this.dishes.length,
          itemBuilder: (context, i) => DishTile(this.dishes[i]),
          padding: EdgeInsets.only(bottom: kFloatingActionButtonMargin + 150)
        ),
      )
    );
  }
}
