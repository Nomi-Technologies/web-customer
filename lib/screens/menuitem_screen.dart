import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:moPass/components/menuitem_page.dart';
import 'package:moPass/models/menu_data.dart';

class MenuItemScreen extends StatelessWidget {

  final int id;
  final bool landingPage;
  static final kTabBarHeight = 60.0;

  MenuItemScreen({
    @required this.id,
    this.landingPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MenuData>(
      future: () async {
        final parsed = json.decode(await DefaultAssetBundle.of(context).loadString('data.json'));
        return MenuData.fromResponse(parsed);
      }(),
      builder: (context, snap) {
        if (snap.hasData) {
          return _MenuItemScreen(snap.data, landingPage);
        } else {
          print(snap.error);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Image(image: AssetImage('assets/icons/arrow_left.png')),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Center(child: Text('LOADING or ERROR', 
              style: TextStyle(color: Colors.white)
            ))
          );
        }
      },
    );

  }
}

class _MenuItemScreen extends StatefulWidget {
  final MenuData menu;
  final bool landingPage;

  _MenuItemScreen(this.menu, this.landingPage);

  @override
  _MenuItemScreenState createState() => _MenuItemScreenState();
}

class _MenuItemScreenState extends State<_MenuItemScreen> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      vsync: this, 
      length: widget.menu.categories.length,
      initialIndex: 0
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tabBar = TabBar( //scrollable tabs
      controller: _controller,
      isScrollable: true,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 4.0, color: theme.accentColor)
      ),
      tabs: widget.menu.categories.map<Tab>(
        (String category) => Tab(text: category)
      ).toList(),
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(tabBar.preferredSize.height),
        child: Container(
          alignment: Alignment.center,
          child: tabBar,
          decoration: BoxDecoration(color: theme.primaryColor,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          TabBarView(
            controller: _controller,
            children: widget.menu.categories.map<Widget>((String category) =>
              MenuItemPage(widget.menu.dishesByCategory[category])
            ).toList()
          ),
        ]
      ),
    );
  }
}