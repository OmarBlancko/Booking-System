import 'package:bookingsystem/models/room.dart';
import 'package:flutter/material.dart';
import 'package:bookingsystem/helper/DBHelper.dart';

class HotelRooms with ChangeNotifier {
  List<Room> _rooms = [];
  List<Room> get rooms {
    return [..._rooms];
  }

  void setRooms(List<Room> r) {
    _rooms = r;
  }

  final dbHelper = DBHelper.instance;

  // Future<List<Room>> getAndFetchHotelRooms() async {
  //   try {
  //     // final instance = db.getInstance();
  //     final dataList = await dbHelper.getData('room');
  //     _rooms = dataList
  //         .map(
  //           (room) => Room(
  //               roomNumber: room['roomNum'],
  //               hotelId: room['hotelid'],
  //               status: room['status'],
  //               roomType: room['roomType'],
  //               roomPrice: room['roomPrice']),
  //         )
  //         .toList();
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //   }
  //   return [..._rooms];
  // }

  Future<void> getSpecificHotelRooms(String hid) async {
    try {
      // final instance = DBHelper.getInstance();
      final dataList = await dbHelper.getData('room');
      _rooms = dataList
          .map(
            (room) => Room(
                roomNumber: room['roomNum'],
                hotelId: room['hotelid'],
                status: room['status'],
                roomType: room['roomType'],
                roomPrice: room['roomPrice']),
          )
          .where((element) => element.status == 0 && element.hotelId == hid).toList();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Room findRoomById(String id) {
    return _rooms.firstWhere((room) => room.roomNumber.toString() == id);
  }
}
