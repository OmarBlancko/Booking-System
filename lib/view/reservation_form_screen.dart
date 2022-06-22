import 'package:bookingsystem/helper/sizeHelper.dart';
import 'package:bookingsystem/provider/hotel_rooms.dart';
import 'package:bookingsystem/provider/reservation_cart_provider.dart';
import 'package:bookingsystem/view/cart_screen.dart';
import 'package:bookingsystem/view/home_screen.dart';
import 'package:bookingsystem/widgets/common_widgets.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReservationForm extends StatefulWidget {
  static const routeName = '/reservationForm';

  @override
  State<ReservationForm> createState() => _ReservationFormState();
}

DateTime startDate = DateTime.now();
DateTime endDate = DateTime.now().add(const Duration(days: 1));

class _ReservationFormState extends State<ReservationForm> {
  int numOfPersons = 1;
  int maxPerRoom = 2;
  @override
  Widget build(BuildContext formContext) {
    final size = SizeHelper(formContext);
    final dateTextStyle = TextStyle(
        fontFamily: 'Aller',
        fontWeight: FontWeight.bold,
        color: Theme.of(formContext).colorScheme.secondary,
        fontSize: size.getWidth(15.5));
    final dateButtonStyle = ButtonStyle(
      elevation: MaterialStateProperty.all(3),
      backgroundColor: MaterialStateProperty.all(
          Theme.of(formContext).colorScheme.secondary),
    );
    final labelTextStyle =
        TextStyle(fontSize: size.getWidth(16), fontFamily: 'Aller');
    final roomDetails =
        Provider.of<HotelRooms>(formContext).findRoomById(roomId.toString());
    roomDetails.roomType == 'single'
        ? maxPerRoom = 2
        : roomDetails.roomType == 'double'
            ? maxPerRoom = 4
            : maxPerRoom = 6;
    void _addRoomToList() {
      bool notExist = Provider.of<ReservationCart>(context, listen: false)
          .addRoom(roomDetails, startDate, endDate, numOfPersons);
      Fluttertoast.showToast(
          msg: notExist?'Room added to reservation list' : 'Room already added check out now' , gravity: ToastGravity.BOTTOM);
    }

    return Scaffold(
      backgroundColor: Theme.of(formContext).colorScheme.primary,
      body: Container(
        padding: EdgeInsets.only(top: size.getHeight(80)),
        height: size.getHeight(800),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: size.getWidth(10)),
              height: size.getHeight(50),
              child: Text(
                'Confirm  your room reservation',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.getHeight(25),
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Aller',
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: size.getWidth(12), bottom: size.getHeight(8)),
              child: Text(
                'Room Details',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: size.getWidth(22),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Aller',
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: size.getWidth(12), bottom: size.getHeight(10)),
              height: size.getHeight(100),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RoomDetailsText(
                      'room number ${roomDetails.roomNumber.toString()}', 22),
                  RoomDetailsText('${roomDetails.roomType} room', 22),
                  RoomDetailsText('room price ${roomDetails.roomPrice} \$', 22),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: size.getWidth(10)),
              height: size.getHeight(250),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HintText('number of persons '),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      width: double.infinity,
                      height: size.getHeight(50),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '${numOfPersons < 1 ? numOfPersons = 1 : numOfPersons}',
                              style: TextStyle(
                                fontSize: size.getWidth(35),
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.getWidth(60),
                          ),
                          Flexible(
                            child: IconButton(
                              icon: Icon(
                                Icons.add_circle,
                                color: Colors.lightBlueAccent,
                                size: size.getWidth(31),
                              ),
                              onPressed: () {
                                if (numOfPersons < maxPerRoom) {
                                  setState(() {
                                    numOfPersons = numOfPersons + 1;
                                  });
                                }
                              },
                            ),
                          ),
                          Flexible(
                            child: IconButton(
                              icon: Icon(
                                Icons.remove_circle,
                                color: Colors.lightBlueAccent,
                                size: size.getWidth(31),
                              ),
                              onPressed: () {
                                setState(() {
                                  numOfPersons = numOfPersons - 1;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: size.getHeight(159),
                    width: size.getWidth(389),
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: size.getHeight(16),
                                  right: size.getHeight(84),
                                ),
                                child: Text(
                                  'Start date',
                                  style: dateTextStyle,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(left: 8),
                                width: size.getWidth(170),
                                child: TextField(
                                  style: labelTextStyle,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.calendar_today_outlined,
                                      size: size.getWidth(23),
                                      color: Colors.lightBlueAccent,
                                    ),
                                    label: Text(
                                      '${formatDate(startDate, [
                                            yyyy,
                                            '-',
                                            mm,
                                            '-',
                                            dd
                                          ])}',
                                      style: TextStyle(
                                          color: Colors.lightBlueAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.getWidth(16)),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(right: size.getHeight(22)),
                                child: ElevatedButton(
                                  style: dateButtonStyle,
                                  child: Text(
                                    'Tap to change',
                                    style: TextStyle(
                                        color: Theme.of(formContext)
                                            .colorScheme
                                            .primary,
                                        fontSize: size.getWidth(15.5)),
                                  ),
                                  onPressed: () async {
                                    showDatePicker(
                                            context: formContext,
                                            initialDate: startDate,
                                            firstDate: startDate,
                                            lastDate: DateTime(2022, 12, 31))
                                        .then((value) {
                                      if (value != null)
                                        setState(() {
                                          startDate = value;
                                          endDate =
                                              startDate.add(Duration(days: 1));
                                          print(startDate);
                                        });
                                      else
                                        print('null value');
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.getWidth(15),
                        ),
                        Column(
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: size.getHeight(16),
                                    right: size.getWidth(78.5)),
                                child: Text(
                                  'Leave date',
                                  style: dateTextStyle,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                width: size.getWidth(170),
                                padding: EdgeInsets.only(left: 6),
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.calendar_today_outlined,
                                      size: size.getWidth(23),
                                      color: Colors.lightBlueAccent,
                                    ),
                                    label: Text(
                                        '${formatDate(endDate, [
                                              yyyy,
                                              '-',
                                              mm,
                                              '-',
                                              dd
                                            ])}',
                                        style: TextStyle(
                                            color: Colors.lightBlueAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: size.getWidth(17)),
                                        textAlign: TextAlign.left),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(right: size.getWidth(21)),
                                child: ElevatedButton(
                                  style: dateButtonStyle,
                                  child: Text(
                                    'Tap to change',
                                    style: TextStyle(
                                        color: Theme.of(formContext)
                                            .colorScheme
                                            .primary,
                                        fontSize: size.getWidth(15.5)),
                                  ),
                                  onPressed: () async {
                                    showDatePicker(
                                      context: formContext,
                                      initialDate: endDate,
                                      firstDate: endDate,
                                      lastDate: DateTime(2022, 12, 31),
                                    ).then((value) {
                                      if (value != null)
                                        setState(() {
                                          endDate = value;
                                          print(endDate);
                                        });
                                      else
                                        print('null value');
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(5),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary),
                  ),
                  child: Text(
                    'Add to reservation list',
                    style: TextStyle(
                      fontSize: size.getWidth(22),
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onPressed: _addRoomToList,
                ),
              ),
            ),
            Flexible(
              child: Center(
                child: Container(
                  child: TextButton(
                    child: Text('Go to reservation List',style: TextStyle(
                      color: Colors.white,
                      fontSize: size.getWidth(22),
                    ),),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoomDetailsText extends StatelessWidget {
  late final double fontSize;
  late final String roomText;
  RoomDetailsText(this.roomText, this.fontSize);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: Colors.lightBlueAccent,
          size: MediaQuery.of(context).size.width * .035,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          '$roomText',
          style: TextStyle(
              fontSize: fontSize,
              color: Colors.lightBlueAccent,
              fontWeight: FontWeight.w500,
              fontFamily: 'Aller'),
        ),
      ],
    );
  }
}
