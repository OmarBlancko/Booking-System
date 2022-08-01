import 'package:bookingsystem/main.dart';
import 'package:bookingsystem/view/reservation_form_screen.dart';
import 'package:bookingsystem/view/home_screen.dart';
import '../helper/sizeHelper.dart';
import 'package:flutter/material.dart';

class RoomView extends StatelessWidget {
  late final int roomNumber;
  late final double roomPrice;
  late final String type;
  late final int roomStatus; // 0 for available rooms 1 for reserved
  RoomView(
      {required this.roomNumber,
      required this.roomPrice,
      required this.type,
      required this.roomStatus});
  @override
  Widget build(BuildContext context) {
    final size = SizeHelper(context);
    final roomDetailsFontStyle =  TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xffffffff),
        fontSize: size.getWidth(16),
      fontFamily: 'Oswald',
      letterSpacing: size.getHeight(2),
    );

    return ClipRRect(
      // borderRadius: BorderRadius.only(
      //   topLeft: Radius.circular(size.getWidth(7)) ,
      //   topRight: Radius.circular(size.getWidth(7)),
      //   bottomLeft: Radius.circular(size.getWidth(7)),
      //   bottomRight: Radius.circular(size.getWidth(7)),
      // ),
      child: Container(
        margin: EdgeInsets.only(bottom: size.getHeight(10)),
        width: size.getWidth(360),
        height: size.getHeight(290),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
          color: Theme.of(context).colorScheme.primary,

        ),
        // padding: EdgeInsets.only(right: 8,left: 8),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.asset(
                  'assets/images/$type.jpg',
                  fit: BoxFit.fill,
                 width:size.getWidth(385),
                  height: size.getHeight(235),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    decoration:BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(.4),
                    ) ,
                    width: size.getWidth(392.2),
                    height: size.getHeight(60),
                    padding: EdgeInsets.only(left: size.getWidth(10),right: size.getWidth(10),top: size.getHeight(15),bottom: size.getHeight(10)),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: size.getWidth(10),),
                        Container(
                          width: 30,
                          child: Text(
                            '$roomNumber',
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: size.getWidth(35),
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                        ),
                       SizedBox(width: size.getWidth(20),),
                       Flexible(
                         child: Container(
                           width: 120,
                           child: Text(
                                '$type'.toUpperCase(),
                                style: roomDetailsFontStyle,
                            ),
                         ),
                       ),
                        SizedBox(width: size.getWidth(10),),

                        Flexible(
                          child: Text(
                            '$roomPrice\$',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffffffff),
                                fontSize: size.getWidth(20)
                            ),
                          ),
                        ),
                        SizedBox(width: size.getWidth(20),),


                        SizedBox(width: size.getWidth(25),),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                roomStatus == 1
                                    ? Icons.event_busy
                                    : Icons.event_available,
                                color: roomStatus == 1 ? Colors.red : Colors.greenAccent,
                                size: size.getWidth(25),
                              ),
                              Text(roomStatus == 1 ? 'Reserved' : 'Available',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                  fontSize: size.getWidth(15)
                              ),),

                            ],
                          ),
                        ),

                          // TextButton(
                          //   onPressed: () {
                          //     roomId=roomNumber;
                          //     Navigator.push(context,MaterialPageRoute(builder: (context) => ReservationForm()));
                          //     },
                          //   child:  Text(
                          //     'Book now',
                          //     style: TextStyle(
                          //         color: Colors.greenAccent, fontWeight: FontWeight.bold,
                          //         fontSize: size.getWidth(14)),
                          //     ),
                          // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (roomStatus == 0)
              Container(
                padding: EdgeInsets.only(top: size.getHeight(10)),
                height: size.getHeight(50),
                width: double.infinity,
                child: TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
                    // backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () {
                    roomId=roomNumber;
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ReservationForm()));
                  },
                  child:  Text(
                    'Book Now',
                    style: TextStyle(
                        color: Colors.greenAccent, fontWeight: FontWeight.bold,
                        fontSize: size.getWidth(20),
                    fontFamily: 'OpenSans'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
