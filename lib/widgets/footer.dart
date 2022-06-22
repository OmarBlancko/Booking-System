import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:0, bottom: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SocialIcon(FontAwesomeIcons.facebook),
          SocialIcon(
            FontAwesomeIcons.whatsapp,
          ),
          SocialIcon(
            FontAwesomeIcons.twitter,
          ),
          SocialIcon(
            FontAwesomeIcons.linkedin,
          ),
          SizedBox(
            width: 60,
          ),
          SocialIcon(FontAwesomeIcons.phone),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class SocialIcon extends StatelessWidget {
  late IconData data;
  SocialIcon(this.data);
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: FittedBox(child: Icon(data, size: 30,color: Theme.of(context).colorScheme.secondary,)),
      padding: EdgeInsets.only(right: 4, left: 4, bottom: 5),
    );
  }
}
