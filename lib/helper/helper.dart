import 'package:flutter/material.dart';
bool validateEmail(String? email) {
  final emailReg = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return emailReg.hasMatch(email!);
}
SnackBar getSnackBar(String msg) {
  return SnackBar(content: Text(msg),duration: Duration(seconds: 2),);
}
class ShowSnackBar extends StatelessWidget {
  late final String msg;
  ShowSnackBar(this.msg);
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(msg),
    );
  }
}
