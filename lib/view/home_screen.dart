import 'package:bookingsystem/main.dart';
import 'package:bookingsystem/models/hotel.dart';
import 'package:bookingsystem/view/room_details_screen.dart';
import 'package:bookingsystem/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:bookingsystem/provider/hotel_rooms.dart';
import 'package:provider/provider.dart';
import 'package:bookingsystem/widgets/room_view.dart';
import 'package:bookingsystem/provider/hotel_branch.dart';
import 'package:bookingsystem/widgets/footer.dart';
import 'package:bookingsystem/widgets/welcomeWidget.dart';

var roomId = 0;
class ViewScreen extends StatefulWidget {
  static const routeName = '/viewScreen';
  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  List<dynamic> list = [];
  String hotelId = '1';
  List<String> hotelBranches = [];

  /// tahrir 1 giza 2 tagmoo 3
  String dropDownValue = 'Tahrir';
  @override
 // h = 835.6 , w = 392.7
  @override
  Widget build(BuildContext context) {
    final deviceSize = getSize(context);
    return Scaffold(
      // bottomNavigationBar: Builder(
      //   builder: (BuildContext context) {
      //     return BottomAppBar(
      //       color: Theme.of(context).colorScheme.primary,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         mainAxisSize: MainAxisSize.max,
      //         children: <Widget>[
      //           IconButton(
      //               icon: Icon(Icons.menu,
      //                   color: Theme.of(context).colorScheme.secondary),
      //               onPressed: () {
      //                 Scaffold.of(context).openDrawer();
      //               }),
      //           IconButton(
      //               icon: Icon(
      //                 Icons.message,
      //                 color: Theme.of(context).colorScheme.secondary,
      //               ),
      //               onPressed: () {}),
      //         ],
      //       ),
      //     );
      //   },
      // ), ///// //
      /// navigation bar
      drawer: AppDrawer(),
      body: SafeArea(
        child: Builder(
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 6, top: 3),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.menu, size: 30), onPressed: () {
                        Scaffold.of(context).openDrawer();
                      }),
                    ],
                  ),
                ),

                WelcomeWidget(),
                Container(
                  width: deviceSize.width * .97,
                  height: deviceSize.height * 0.05883,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: FittedBox(
                          child: Text(
                          'Please Select Hotel Branch',
                          style: TextStyle(
                            fontSize: deviceSize.width * .038,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
                      ),
                      SizedBox(
                        width: deviceSize.width * 0.1273,
                      ),
                      Container(
                        width: deviceSize.width * 0.286,
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            style: TextStyle(
                              fontSize: deviceSize.width * .035
                            ),
                            dropdownColor: Theme.of(context).colorScheme.primary,
                            icon: LayoutBuilder(
                              builder: (context, constraints) {
                                return new Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                  color: Theme.of(context).colorScheme.secondary,
                                  size: constraints.biggest.height,
                                );
                              }),
                            value: dropDownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropDownValue = newValue!; // parameter new vale
                                dropDownValue == 'Tahrir'
                                    ? hotelId = '1'
                                    : dropDownValue == 'Giza'
                                    ? hotelId = '2'
                                    : hotelId = '3';
                              });
                            },
                            items: <String>['Tahrir', 'Giza', 'Tagmoo']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: deviceSize.width * .038,
                                      color: Theme.of(context).colorScheme.secondary),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  height: deviceSize.height * 0.0578,
                  width: deviceSize.width * .99,
                  child: Row(
                    children: <Widget>[
                      LayoutBuilder(builder: (context, constraints) {
                        return new  Icon(
                            Icons.location_on,
                          size: deviceSize.width * .054,
                        );},),
                      FutureBuilder(
                          future: Provider.of<HotelBranch>(context, listen: false)
                              .getAndFetchHotels(),
                          builder: (_, hotelSnapshot) {
                            if (hotelSnapshot.hasError) {
                              return Text('Something goes wrong',style: TextStyle(fontSize: deviceSize.width*.042));
                            } else if (hotelSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text(
                                  'We are bringing the data for you please wait :)',style: TextStyle(fontSize: deviceSize.width*.042));
                            } else if (hotelSnapshot.connectionState ==
                                ConnectionState.done) {
                              return Consumer<HotelBranch>(
                                builder: (_, hotelData, c) =>

                                // ignore: unnecessary_null_comparison
                                Text(
                                    '${hotelData.hotels.firstWhere((element) => element.hotelId == hotelId,
                                        orElse: () => Hotel(hotelId: '', location: '', address: '', numOfRooms: 1)).address}',
                                style: TextStyle(fontSize: deviceSize.width*.0381,
                                fontWeight: FontWeight.bold,),),
                              );
                            } else
                              return Text('Something goes wrong');
                          }),
                    ],
                  ),
                ),
                Container(
                  height: deviceSize.height * 0.5523,
                  child: FutureBuilder(
                    future: Provider.of<HotelRooms>(context, listen: false)
                        .getSpecificHotelRooms(hotelId),
                    builder: (_, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                            child: Text('Something goes wrong please try later'));
                      } else {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                            heightFactor: 10,
                          );
                        } else {
                          return Consumer<HotelRooms>(
                            builder: (_, roomData, child) => ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: roomData.rooms.length,
                              itemBuilder: (ctx, i) => roomData.rooms[i].status == 0
                                  ? GestureDetector(
                                onTap: () {
                                  // ID.roomId = roomData.rooms[i].roomNumber;
                                  roomId = roomData.rooms[i].roomNumber;
                                  Navigator.of(context).pushNamed(
                                      RoomScreenDetails.routeName,
                                      arguments:
                                      roomData.rooms[i].roomNumber);
                                },
                                child: Center(
                                  child: RoomView(
                                    roomNumber: roomData.rooms[i].roomNumber,
                                    roomPrice: roomData.rooms[i].roomPrice,
                                    roomStatus: roomData.rooms[i].status,
                                    type: roomData.rooms[i].roomType,
                                  ),
                                ),
                              )
                                  : Center(
                                child: RoomView(
                                  roomNumber: roomData.rooms[i].roomNumber,
                                  roomPrice: roomData.rooms[i].roomPrice,
                                  roomStatus: roomData.rooms[i].status,
                                  type: roomData.rooms[i].roomType,
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
                Container(
                  height: deviceSize.height * 0.0538,
                  color: Theme.of(context).colorScheme.secondary,
                  // shape: CircularNotchedRectangle(),
                  child: Footer(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
