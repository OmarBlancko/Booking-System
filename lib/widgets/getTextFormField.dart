import 'package:bookingsystem/helper/helper.dart';
import 'package:bookingsystem/main.dart';
import 'package:flutter/material.dart';

class getFormField extends StatelessWidget {
  late final String labelText;
  FocusNode? focusNode = FocusNode();
  FocusNode? nextFocusNode = FocusNode();
  bool? isObscureText;
  late final IconData iconData;
    // ignore: non_constant_identifier_names
    //  void(String s)  onsaved;
  getFormField(
      {required this.labelText, required this.iconData,this.focusNode,this.nextFocusNode,this.isObscureText,});
  @override
  Widget build(BuildContext context) {
    final deviceSize = getSize(context);
    final labelTextStyle =
        TextStyle(fontSize: deviceSize.width * .04, fontFamily: 'Aller');
    return TextFormField(
      maxLines: 1,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        icon: Icon(iconData),
      ),
      style: labelTextStyle,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(nextFocusNode);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your $labelText';
        }
        if ( labelText == 'email' && !validateEmail(value))
          {
            return 'Enter valid email';
          }
      },
    );
  }
}
