import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../helper/sizeHelper.dart';
import '../provider/guest_provider.dart';
class UserAvatarName extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<NewUser>(context).signedUser;
    final size = SizeHelper(context);
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: size.getHeight(40),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Icon(
            FontAwesomeIcons.userCircle,
            size: size.getWidth(50),
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            UserNameTitle(text: userData!.firstName),
            SizedBox(width: size.getWidth(5),),
            UserNameTitle(text: userData.lastName),
          ],
        ),
      ],
    );
  }
}

class UserNameTitle extends StatelessWidget {
  const UserNameTitle({
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    final size = SizeHelper(context);

    return Text('$text',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: size.getWidth(20),
      ),);
  }
}
