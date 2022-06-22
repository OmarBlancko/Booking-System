import 'package:flutter/material.dart';


import '../helper/sizeHelper.dart';
class HintText extends StatelessWidget {
  late final String _hintText;
  HintText(this._hintText);
  @override
  Widget build(BuildContext context) {
    final size = SizeHelper(context);
    // final dateTextStyle = TextStyle(
    //     fontFamily: 'Aller',
    //     fontWeight: FontWeight.bold,
    //     color: Theme.of(context).colorScheme.primary.withOpacity(.6),
    //     fontSize: deviceSize.width * .039);
    // final dateButtonStyle = ButtonStyle(
    //   elevation: MaterialStateProperty.all(3),
    //   backgroundColor:
    //   MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
    // );
    // final labelTextStyle = TextStyle(
    //     fontSize: deviceSize.width * .04,
    //     fontFamily: 'Aller');
    // DateTime startDate = DateTime.now();
    // DateTime endDate = DateTime.now().add(const Duration(days: 1));
    return Container(
      margin: EdgeInsets.only(
          top: size.getHeight(8),
          left: size.getWidth(5)),
      child: Text(
        _hintText,
        style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
            fontFamily: 'Aller'),
      ),
    );
  }
}
