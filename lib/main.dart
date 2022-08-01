import 'package:bookingsystem/provider/auth.dart';
import 'package:bookingsystem/provider/guest_provider.dart';
import 'package:bookingsystem/provider/reservation_cart_provider.dart';
import 'package:bookingsystem/view/auth_screen.dart';
import 'package:bookingsystem/view/cart_screen.dart';
import 'package:bookingsystem/view/reservation_form_screen.dart';
import 'package:bookingsystem/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bookingsystem/provider/hotel_rooms.dart';
import 'package:bookingsystem/provider/hotel_branch.dart';
import 'view/home_screen.dart';
import 'package:bookingsystem/view/room_details_screen.dart';
import 'package:bookingsystem/helper/custom_route.dart';
// class ID {
//   static  int roomId = -1;
// }
  Size  getSize(BuildContext context) {
  return MediaQuery.of(context).size;
}
var userIdentification;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> items;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: HotelRooms(),
          ),
          ChangeNotifierProvider.value(value: HotelBranch()),

          ChangeNotifierProvider.value(value: NewUser()),
          ChangeNotifierProvider.value(value: Authentication()),
          ChangeNotifierProvider.value(value: ReservationCart()),
        ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,


              title: 'Booking System',
              theme: ThemeData(
                scaffoldBackgroundColor: Color(0xfff4ddcd),
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: Color(0xff171E3A),
                  secondary: Color(0xffF4DAC7),
                ),
                pageTransitionsTheme:PageTransitionsTheme(
                  builders:{
                    TargetPlatform.android:CustomPageTransitionBuilder(),
                    TargetPlatform.iOS:CustomPageTransitionBuilder(),
                  }
                ),
                // primarySwatch: Colors.red,
              ),
          //     home: FutureBuilder(
          //       future:   Firebase.initializeApp(),
          //       builder: (context,snapshot) {
          //         if(snapshot.hasError)
          //           return CircularProgressIndicator(color: Colors.red,);
          //         else if(snapshot.connectionState == ConnectionState.done) {
          //           return Splash();
          //         }
          //         else
          //         return CircularProgressIndicator(color: Colors.green,);
          // },
          //     ),
              routes: {
                '/': (ctx) => Splash(),
                ViewScreen.routeName:(ctx) => ViewScreen(),
                RoomScreenDetails.routeName: (ctx) => RoomScreenDetails(),
                AuthScreen.routeName:(ctx) => AuthScreen(),
                ReservationForm.routeName:(ctx) =>ReservationForm(),
                CartScreen.routeName:(ctx) =>CartScreen(),
              },
             ),


    );
  }
}
