import 'package:flutter/material.dart';

import 'package:nui/keys.dart';

import 'package:nui/components/main/lists/lists_page.dart';

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class MainScreen extends StatefulWidget {
  final drawerItems = [
    DrawerItem('Lists', Icons.list),
  ];

  MainScreen() : super(key: AppKeys.mainScreen);

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  int selectedDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.green,
          child: Image.asset('assets/pattern.jpg'),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: this.buildAppBar(),
          drawer: this.buildDrawer(),
          body: Container(
            color: Colors.white,
            child: this.buildContent(),
          ),
        ),
      ],
    );
  }

  Widget buildAppBar() {
    return AppBar(
      elevation: 0.0,
      title: this.buildAppBarTitle(),
      backgroundColor: Colors.transparent,
    );
  }

  Widget buildAppBarTitle() {
    switch (selectedDrawerIndex) {
      case 0:
        return Text('Lists');
      default:
        return Text('Error');
    }
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          this.buildDrawerHeader(),
          ...this.buildDrawerItems(),
        ],
      ),
    );
  }

  Widget buildDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Colors.green,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/pattern.jpg'),
        ),
      ),
      accountName: Text('Name'),
      accountEmail: Text('E-mail'),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: Text(
          'A',
          style: TextStyle(
            fontSize: 40.0,
          ),
        ),
      ),
    );
  }

  List<Widget> buildDrawerItems({
    IconData icon,
    String title,
    String route,
  }) {
    List<Widget> items = [];

    for (var i = 0; i < widget.drawerItems.length; i++) {
      items.add(ListTile(
        leading: Icon(widget.drawerItems[i].icon),
        title: Text(widget.drawerItems[i].title),
        selected: i == selectedDrawerIndex,
        onTap: () => handleSelectDrawerItem(i),
      ));
    }

    return items;
  }

  void handleSelectDrawerItem(int index) {
    setState(() => selectedDrawerIndex = index);
    AppKeys.navigator.currentState.pop();
  }

  Widget buildContent() {
    switch (selectedDrawerIndex) {
      case 0:
        return ListsPage();
      default:
        return Text('Error');
    }
  }
}
