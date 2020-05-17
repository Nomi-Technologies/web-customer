import 'package:flutter/material.dart';
import 'package:moPass/models/filter_data.dart';
import 'package:provider/provider.dart';

class FilterHeaderBar extends StatefulWidget {
  final double height;
  final double panelHeight;

  FilterHeaderBar({
    @required this.height,
    this.panelHeight = 520.0
  });

  @override
  _FilterHeaderBarState createState() => _FilterHeaderBarState();

}

class _FilterHeaderBarState extends State<FilterHeaderBar> {

  bool _expanded = false;
  PersistentBottomSheetController _bottomSheetController;

  void _onExpand() {
    _bottomSheetController = Scaffold.of(context).showBottomSheet((context) => BottomSheet(
      // animationController: _bsac,
      onClosing: () {},
      builder: (context) => SizedBox(height: widget.panelHeight, child: _FilterSlideUpPanel())
    ));
  }

  void _onCollapse() {
    _bottomSheetController.close();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filterData = Provider.of<FilterData>(context);
    final checked = filterData.checkedItemCount;
    return Container(
      margin: EdgeInsets.only(bottom: this._expanded? widget.panelHeight: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        color: theme.primaryColor,
      ),
      alignment: Alignment.center,
      height: widget.height,
      child: Row(children: [
        Container(
          margin: EdgeInsets.only(left: 40.0),
          child: Text('Filters', style: theme.primaryTextTheme.headline1),
        ),
        Container(
          margin: EdgeInsets.only(left: 8.0),
          decoration: BoxDecoration(
            color: checked == 0? Color.fromRGBO(138, 157, 183, 1.0): Colors.red,
            borderRadius: BorderRadius.circular(11.0)
          ),
          alignment: Alignment.center,
          height: 22.0,
          width: 22.0,
          child: Text('$checked',
            style: TextStyle(color: Colors.white, fontSize: 14.0),
          )),
        Spacer(),
        Container(
          height: 44.0,
          child: RaisedButton(
            disabledColor: Color.fromRGBO(138, 157, 183, 0.5),
            color: Color.fromRGBO(138, 157, 183, 1.0),
            child: Text('Clear', 
              style: theme.primaryTextTheme.headline1.apply(color: Colors.white)
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.0)
            ),
            onPressed: checked > 0? filterData.clearFilter: null,
        )),
        IconButton(
          icon: Icon(this._expanded? Icons.expand_more: Icons.expand_less,
            color: theme.buttonColor,
          ), 
          onPressed: () {
            this._expanded? this._onCollapse(): this._onExpand();
            setState(() => this._expanded = !this._expanded);
          }
        ),
      ]),
    );
  }
}

class _FilterSlideUpPanel extends StatelessWidget {

  static final kGridHorizontalPadding = 24.0;
  static final kGridMainAxisSpacing = 20.0;
  static final kGridCellHeight = 44.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filterData = Provider.of<FilterData>(context);
    List tags = [];
    final windowWidth = MediaQuery.of(context).size.width;
    double aspectRatio = (windowWidth - kGridHorizontalPadding * 2 - kGridMainAxisSpacing * 2) / 3.0 / kGridCellHeight;
    filterData.listItems.forEach((key, value) => tags.add(key));
    // Color buttonColor = Color.fromRGBO(243, 163, 92, 1.0);
    return Container(
      color: theme.primaryColor,
      child: Column(children: [
        GridView.count(
          shrinkWrap: true,
          childAspectRatio: aspectRatio,
          padding: EdgeInsets.symmetric(horizontal: kGridHorizontalPadding),
          crossAxisCount: 3,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: kGridMainAxisSpacing,
          children: tags.map((item) {
            bool checked = filterData.getItem(item);
            return FlatButton(
              splashColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2.0, color: Color.fromRGBO(227, 237, 242, 1.0)),
                borderRadius: BorderRadius.circular(4.0),
              ),
              color: checked? Color.fromRGBO(227, 237, 242, 1.0): Color.fromRGBO(249, 249, 249, 1.0),
              onPressed: () {
                filterData.setItem(item, !checked);
              },
              child: Text(item, 
                softWrap: false,
                style: theme.primaryTextTheme.bodyText1
              ),
            );
          }).toList(),
        ),
        // Container(
        //   child: FlatButton(
        //     color: ,
        //   )
        // )
      ]
    ));

  }

}