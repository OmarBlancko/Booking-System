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
    final String sDate =formatDate(room.startDate ?? DateTime.now(), [
      yyyy,
      '-',
      mm,
      '-',
      dd
    ]);
    final String eDate =formatDate(room.endDate ?? DateTime.now(), [
      yyyy,
      '-',
      mm,
      '-',
      dd
    ]);
    final size = SizeHelper(context);
    final dateTextStyle =TextStyle(color: Colors.white);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Text(
            '${room.roomNumber}',
            style: TextStyle(
              color: Colors.black,
              fontSize: size.getWidth(22)
            ),
          ),
        ),
        title: Container(
          padding: EdgeInsets.only(top: size.getHeight(18)),
          child: Text(
            '${room.roomType} room',
            style: TextStyle(color: Colors.white,
                fontSize: size.getWidth(20),
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        subtitle: Container(
          height: size.getHeight(200),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('From\n$sDate',style:dateTextStyle ),
              SizedBox(width: 10,),
              Text('TO',style:dateTextStyle ),
              SizedBox(width: 10,),
              Flexible(child: Text('From\n$eDate',style:dateTextStyle )),
            ],
          ),
        ),
        trailing: Container(
          width: size.getWidth(80),
          height: size.getHeight(50),
          child: Row(
            children: <Widget>[
              Text(
                '${room.roomPrice}',
                style:
                    TextStyle(
                        color: Colors.green,
                        fontSize: size.getWidth(19),
                    fontWeight: FontWeight.bold),
              ),
              Icon(
                FontAwesomeIcons.dollarSign,
                color: Colors.green,
              ),
            ],
          ),
          
        ),
        isThreeLine: true,
      ),
    );
  }
}
