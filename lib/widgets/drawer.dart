import 'package:bookingsystem/helper/sizeHelper.dart';
import 'package:bookingsystem/models/guest.dart';
import 'package:bookingsystem/provider/auth.dart';
import 'package:bookingsystem/widgets/userProfileAvatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../provider/guest_provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<NewUser>(context).signedUser;
    final size = SizeHelper(context);
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.getHeight(40),
          ),
          UserAvatarName(),
          Divider(),
          ListTile(
            leading: Icon(FontAwesomeIcons.user),
            title: Text('Update Profile'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Reserve now'),
            onTap: () {},
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
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Provider.of<Authentication>(context, listen: false).logout();
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
