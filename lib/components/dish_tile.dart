import 'package:flutter/material.dart';
import 'package:moPass/models/dish.dart';

class DishTile extends StatelessWidget {
  final Dish dish;
  final bool initiallyExpanded;
  final Function(bool) onExpansionChanged;

  DishTile(this.dish, {this.initiallyExpanded, @required this.onExpansionChanged});

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
        initiallyExpanded: this.initiallyExpanded,
        onExpansionChanged: this.onExpansionChanged,
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
        ],
      ),
    );
  }

  
}

// class _AllergenIconBar extends StatelessWidget {
//   final List<String> _allergens;

//   _AllergenIconBar(this._allergens);

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     //List<GestureDetector> allergenIcons = [];
//     List<Image> allergenIcons = [];
//     for (String allergen in _allergens) {
//       String path = 'assets/icons/allergens/$allergen.png';
//       allergenIcons.add(Image(image: AssetImage(path), width: 32.0,height:32.0));
//     }
    
//     return GestureDetector(
//       onTap:(){
//          showDialog(
//             barrierDismissible: true,
//             context: context,
//             builder: (context) =>
//               AlertDialog(
//                 backgroundColor: Color.fromRGBO(57, 57, 57, 1),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//                 title: Text("Contains: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22.0)),
//                 content: Container(
//                   width: 200.0,
//                   height: 115.0,
//                   child: Scrollbar(
//                     child: ListView(
//                       children: new List.generate(_allergens.length, (index){
//                         return Padding(
//                           padding: EdgeInsets.only(bottom: 16.0),
//                           child: Row(
//                             children: <Widget>[
//                               Padding(
//                                 padding: EdgeInsets.only(right: 20.0),
//                                 child: allergenIcons[index]
//                               ),
//                               Text(_allergens[index], style: theme.primaryTextTheme.bodyText1)
//                             ],
//                           )
//                         );
//                       })
//                     )
//                   )
//                 )
//               )
//           );
        
//       },
//       child: Container(
//         decoration: BoxDecoration(border: Border(top: BorderSide(
//           color: Color.fromRGBO(83, 131, 236, 0.15),
//           width: 1.0
//         ))),
//         child: GridView.extent(
//           crossAxisSpacing: 15.0,
//           mainAxisSpacing: 15.0,
//           padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//           shrinkWrap: true,
//           primary: false,
//           maxCrossAxisExtent: 32.0,
//           children: allergenIcons
//         )
//     ));
//   }

// }