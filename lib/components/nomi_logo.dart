import 'package:flutter/material.dart';

class NomiLogo extends StatelessWidget {

  final Color color;

  NomiLogo({
    this.color = Colors.white
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Powered by',
              style: TextStyle(
                color: this.color,
                fontSize: 18.0,
              ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8.0, bottom: 4.0),
            child: Image(
              height: 16.0,
              image: AssetImage('assets/icons/nomi-white-withword.png'), 
              color: this.color,
            )
          )
      ])
    );
  }
}