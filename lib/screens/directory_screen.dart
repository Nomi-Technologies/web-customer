import 'package:flutter/material.dart';
import 'package:moPass/components/menu_button.dart';
import 'package:moPass/components/nomi_logo.dart';
import 'package:moPass/screens/menuitem_screen.dart';

class DirectoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            children: [
              _DirectoryItemButton(text: 'Bacari',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuItemScreen(id: 1))
                )
              ),
            ]
          ),
          Expanded(
            child: Align(alignment: Alignment.bottomCenter,
              child: NomiLogo(color: Color.fromRGBO(128, 128, 128, 1.0))
            ),
          )
        ]
      )
    );
  }
}

class _DirectoryItemButton extends StatelessWidget {

  final text;
  final void Function() onPressed;

  _DirectoryItemButton({
    this.text,
    @required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0), 
      child: MenuButton(
        text: text, 
        onPressed: onPressed,
        overlay: Container(
          alignment: Alignment.centerRight,
          child: Image(image: AssetImage('assets/icons/arrow_right.png'))
        ),
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      )
    );
  }
}