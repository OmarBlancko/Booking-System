import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookingsystem/provider/hotel_rooms.dart';
import 'package:bookingsystem/provider/hotel_branch.dart';
import 'home_screen.dart';
import 'package:bookingsystem/view/room_details_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: HotelRooms(),
        ),
        ChangeNotifierProvider.value(value: HotelBranch())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        routes: {
          '/':(ctx) =>ViewScreen(),
          RoomScreenDetails.routeName: (ctx) =>RoomScreenDetails(),
        },
      ),
    );
  }
}
