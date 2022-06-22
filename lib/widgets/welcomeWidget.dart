import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width * .94,
      height: deviceSize.height * .19,
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.only(top: 30, left: 17),
      decoration: BoxDecoration(
        border:
            Border.all(color: Theme.of(context).colorScheme.primary, width: 3),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              FittedBox(
                child: Text(
                  'Hi Guest,',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 28,
                      fontFamily: 'Aller',
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: deviceSize.width * 0.0254,
              ),
              SizedBox(
                height: deviceSize.height * 0.0418,
                width: deviceSize.width * 0.0891,
                child: Image.asset('assets/images/Wave.png'),
              ),
            ],
          ),
          SizedBox(
            height: deviceSize.height * 0.00957,
          ),
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: FittedBox(
              child: Text(
                'Feel free to reserve your room',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Aller',
                    color: Theme.of(context).colorScheme.primary),
              ),
            ),
          )
        ],
      ),
    );
  }
}
