import 'package:bookingsystem/helper/sizeHelper.dart';
import 'package:bookingsystem/main.dart';
import 'package:flutter/material.dart';
import 'package:bookingsystem/provider/hotel_rooms.dart';
import 'package:provider/provider.dart';

class RoomScreenDetails extends StatelessWidget {
  static const routeName = '/room_details';
  @override
  Widget build(BuildContext context) {
    final String roomId = ModalRoute.of(context)!.settings.arguments.toString();
    final roomDetails = Provider.of<HotelRooms>(context).findRoomById(roomId);
    final size= SizeHelper(context);
    return Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              height: size.getHeight(300),
              child: Image.asset('assets/images/${roomDetails.roomType}.jpg',fit: BoxFit.fill,),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.getWidth(10) )
                ),
                height: size.getHeight(500),
              ),
            ),
          ],
        ));
  }
}
class RowTextAndIconWidget extends StatelessWidget {
late final String label;
late final IconData icon;
RowTextAndIconWidget(this.label,this.icon);
  @override
  Widget build(BuildContext context) {
    final deviceSize = getSize(context);
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: deviceSize.width * .056,
        ),
        SizedBox(width: 5,),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: deviceSize.width*.054,
            fontWeight: FontWeight.bold,
          ),
        ),

      ],
    );
  }
}
// final temp = CustomScrollView(
//   slivers: [
//     SliverAppBar(
//       pinned: true,
//       expandedHeight: deviceSize.height * 0.3233,
//       flexibleSpace: FlexibleSpaceBar(
//         centerTitle: false,
//         title: Padding(
//           padding: EdgeInsets.only(right: 15,bottom: 5),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Row(
//                 children: <Widget>
//                 [
//                   Icon(
//                     Icons.checkroom_outlined,
//                     color: Theme.of(context).colorScheme.secondary,
//                     size: deviceSize.width * .066,
//                   ),
//                   SizedBox(width: 5,),
//                   Text(
//                     'Room Details',
//                     style: TextStyle(
//                       color: Theme.of(context).colorScheme.secondary,
//                       fontSize: deviceSize.width*.056,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         background: Hero(
//           tag: roomDetails.roomNumber,
//           child: Image.asset('assets/images/${roomDetails.roomType}.jpg',
//               fit: BoxFit.fill),
//         ),
//       ),
//     ),
//     SliverList(
//       delegate: SliverChildListDelegate([
//         Container(
//           height:deviceSize.height * .25 ,
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//             ),
//             color: Theme.of(context).colorScheme.secondary,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     if(roomDetails.status == 0 )
//                       RowTextAndIconWidget('Available', Icons.event_available),
//                     SizedBox(
//                       height: deviceSize.height*.02,
//                     ),
//                     RowTextAndIconWidget(
//                         ' ${roomDetails.roomNumber.toString()}',
//                         Icons.sensor_door_sharp),
//                     SizedBox(
//                       height: deviceSize.height*.02,
//                     ),
//                     RowTextAndIconWidget(' ${roomDetails.roomPrice.toStringAsFixed(2)}\$', Icons.price_change),
//                     SizedBox(
//                       height: deviceSize.height*.02,
//                     ),
//                   ],
//                 ),
//                 Padding(
//                     padding: EdgeInsets.only(left: 5),
//                     child: RowTextAndIconWidget(' ${roomDetails.roomType}', Icons.hotel_outlined)),
//                 SizedBox(height: 10,),
//
//               ],
//             ),
//           ),
//         ),
//         Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 height: 700,
//               ),
//               ButtonBar(
//                 children: [Text('Book Now')],
//               )
//             ],
//           ),
//         ),
//       ]),
//     )
//   ],
// );