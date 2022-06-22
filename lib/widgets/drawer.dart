import 'package:bookingsystem/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Guest'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Reserve now'),
            onTap: () {

            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Payment'),
            onTap: () {

              // Navigator.of(context).pushReplacement(CustomRoute(
              //     builder: (ctx) => OrdersScreen(),), );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.book_online),
            title: Text('Your reservations'),
            onTap: () {

            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {

              Provider.of<Authentication>(context,listen: false).logout();
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
