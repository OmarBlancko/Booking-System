import 'package:bookingsystem/main.dart';
import 'package:bookingsystem/models/guest.dart';
import 'package:bookingsystem/provider/auth.dart';
import 'package:bookingsystem/provider/guest_provider.dart';
import 'package:bookingsystem/view/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookingsystem/helper/DBHelper.dart';
import 'package:provider/provider.dart';
class Splash extends StatefulWidget {
  static const routeName = '/splashScreen';

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
  }
_verifiedUser() async {
    await Provider.of<NewUser>(context,listen: false).getUserData();
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => ViewScreen())).then((value)  {
  });
}
  _navigateToHome() async {
    await DBHelper.instance.initializeDatabase();
    await Future.delayed(
      Duration(
        seconds: 0,
      ),
      () {},
    );
    bool result = await Provider.of<Authentication>(context,listen: false).tryAutoLogin();

    result == true ?
    _verifiedUser()
        :
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AuthScreen())).then((value) {
      // print('not auth');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .7,
          height: MediaQuery.of(context).size.height * .4,
          child: Container(
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
