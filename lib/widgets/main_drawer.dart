import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer(this.chooseFromDrawer, {super.key});

  void Function(String selection) chooseFromDrawer;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsetsGeometry.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 1, 104, 40),
                  const Color.fromARGB(128, 1, 104, 40),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.restaurant_menu),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'PocketChef',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: Text('Meals'),
            onTap: () {
              chooseFromDrawer('meals');
            },
          ),
          ListTile(
            leading: Icon(Icons.filter_alt),
            title: Text('Filter'),
            onTap: () {
              chooseFromDrawer('filters');
            },
          ),
        ],
      ),
    );
  }
}
