import 'package:flutter/material.dart';
import 'package:moPass/models/dish.dart';

class DishTile extends StatelessWidget {
  final Dish dish;

  DishTile(this.dish);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),  color: Theme.of(context).primaryColor),
      margin: EdgeInsets.only(bottom: 15.0),
      padding: EdgeInsets.only(left: 15.0),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        trailing: IconButton(
          padding: EdgeInsets.only(top: 15.0),
          color: Colors.blue,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: Icon(Icons.info),
          onPressed: () => print('POP UP'),
        ),
        title: Container(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(
            color: theme.dividerColor,
            width: 1.0
          ))),
          alignment: Alignment.centerLeft,
          child: Text(
            this.dish.name, 
            style: theme.primaryTextTheme.headline1,
        )),
        subtitle: Container(
          padding: EdgeInsets.only(top: 14.0, bottom: 10.0),
          alignment: Alignment.centerLeft,
          child: Text(
            this.dish.description,
            style: theme.primaryTextTheme.bodyText2
        )),
        children: <Widget>[
          Text('Add to cart')
        ],
      ),
    );
  }

  
}
