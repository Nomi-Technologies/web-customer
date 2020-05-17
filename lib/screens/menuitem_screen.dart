import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/browser_client.dart';
import 'package:moPass/app_config.dart';
import 'package:moPass/components/filter_slideup_panel.dart';
import 'package:moPass/components/menuitem_page.dart';
import 'package:moPass/components/nomi_logo.dart';
import 'package:moPass/models/filter_data.dart';
import 'package:moPass/models/menu_data.dart';
import 'package:moPass/providers/filter_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:moPass/models/dish.dart';

class MenuItemScreen extends StatelessWidget {

  final client = BrowserClient();
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
        final baseUrl = AppConfig.of(context).apiBaseUrl;
        final res = await client.get('$baseUrl/webApi/dishes/$id'); 
        final parsed = json.decode(res.body);
        return MenuData.fromResponse(parsed);
      }(),
      builder: (context, snap) {
        if (snap.hasData) {
          return FilterDataProvider(
            data: snap.data,
            child: _MenuItemScreen(snap.data, landingPage)
          );
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
  // AnimationController _bsac = AnimationController(vsync: null);

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
    final FilterData filterData = Provider.of<FilterData>(context);
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
          // Container(
          //   margin: EdgeInsets.only(bottom: 115.0),
          //   child: NomiLogo(color: Color.fromRGBO(138, 157, 183, 0.5)),
          // ),
          TabBarView(
            controller: _controller,
            children: widget.menu.categories.map<Widget>((String category) {
              List<Dish> dishes = [];
              for (Dish dish in widget.menu.dishesByCategory[category]) {
                if (!filterData.excluded.contains(dish.name)) {
                  dishes.add(dish);
                }
              }
              return MenuItemPage(dishes);  
            }).toList()
          ),
          FilterHeaderBar(height: 80.0),
        ]
      ),
    );
  }
}