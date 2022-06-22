import 'package:bookingsystem/helper/sizeHelper.dart';
import 'package:bookingsystem/provider/reservation_cart_provider.dart';
import 'package:bookingsystem/widgets/cart_room_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cartScreen';

  @override
  Widget build(BuildContext context) {
    final cartObject = Provider.of<ReservationCart>(context,listen: false);
    final cartDetails =cartObject.cartRooms;
    final size = SizeHelper(context);
    return Scaffold(
      body: Column(
          children: <Widget>[
            SizedBox(height: size.getHeight(300),),
            Expanded(
              child: ListView.builder(
                addRepaintBoundaries: true,
                padding: EdgeInsets.all(20),
                shrinkWrap: true,
                  itemCount: cartDetails.length,
                  itemBuilder: (ctx, i) => CartRoomItem(cartDetails[i]),
              ),
            ),
            Center(child: Text('${cartObject.totalAmount}'),),
            // FloatingActionButton(onPressed: (){Navigator.pop(context);},child: Icon(Icons.arrow_back,color: Colors.white,),)
          ],
        ),

    );
  }
}
