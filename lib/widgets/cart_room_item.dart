import 'package:bookingsystem/helper/sizeHelper.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/room.dart';
import 'package:intl/intl.dart';

class CartRoomItem extends StatelessWidget {
  late final Room room;
  CartRoomItem(this.room);
  @override
  Widget build(BuildContext context) {
    final String sDate =
        formatDate(room.startDate ?? DateTime.now(), [yyyy, '-', mm, '-', dd]);
    final String eDate =
        formatDate(room.endDate ?? DateTime.now(), [yyyy, '-', mm, '-', dd]);
    final size = SizeHelper(context);
    final dateTextStyle = TextStyle(color: Colors.white,
    fontSize: size.getWidth(15));
    final ftTextStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: size.getWidth(19),
    );
    return Container(
        padding: EdgeInsets.all(size.getWidth(10)),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(size.getWidth(20)),
        ),
        width: size.getWidth(350),
        height: size.getHeight(200),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: size.getWidth(5),
                ),
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    '${room.roomNumber}',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: size.getWidth(22),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: size.getWidth(10),
                ),
                Container(
                  child: Text(
                    '${room.roomType} room',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: size.getWidth(20),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: size.getWidth(125),
                ),
                Icon(Icons.edit,color: Colors.greenAccent,size: size.getWidth(24),),
              ],
            ),
            SizedBox(height: size.getHeight(20),),
            Row(
              children: [
                SizedBox(width: size.getWidth(55),),
                Text('From',style:ftTextStyle ),
                SizedBox(width: size.getWidth(85),),
                Text('To',style: ftTextStyle),

              ],
            ),
            SizedBox(height: size.getHeight(10),),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: size.getWidth(55),),
                Text('$sDate', style: dateTextStyle),
                SizedBox(
                  width: size.getWidth(50),
                ),

                Flexible(child: Text('$eDate', style: dateTextStyle)),
              ],
            ),
            SizedBox(height: size.getHeight(20),),
            Row(
              children: <Widget>[
                SizedBox(width: size.getWidth(30),),

                Text('Room Price  ',style: ftTextStyle,),
                SizedBox(width: size.getWidth(100),),
                Text(
                  '${room.roomPrice}',
                  style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: size.getWidth(19),
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  FontAwesomeIcons.dollarSign,
                  color: Colors.greenAccent,
                ),
              ],
            ),
          ],
        ));
  }
}
