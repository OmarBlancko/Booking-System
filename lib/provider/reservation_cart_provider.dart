import 'package:flutter/material.dart';

import '../models/room.dart';

class ReservationCart with ChangeNotifier {
// Map<int,Room> _rooms={};
// Map<int,Room> get rooms{
//   return {..._rooms};
// }
  List<Room> _cartRooms = [];
  List<Room> get cartRooms {
    return [..._cartRooms];
  }

  double get totalAmount {
    double total = 0.0;
    _cartRooms.forEach((room) {
      total += room.roomPrice;
    });
    return total;
  }

  bool addRoom(Room newRoom, DateTime start, DateTime end, int numOfGuests) {
    bool exist= _cartRooms.any((element) {
      if(element.roomNumber == newRoom.roomNumber) {
        return true;
      } else
        return false;
    });
    if(exist) {
      print('exist');
      _cartRooms.forEach((element) {
        print(element.roomType);
      });
      return false;
    }
    else {
      _cartRooms.add(Room(
          roomNumber: newRoom.roomNumber,
          hotelId: newRoom.hotelId,
          status: newRoom.status,
          roomType: newRoom.roomType,
          roomPrice: newRoom.roomPrice,
          startDate: start,
          endDate: end,
          numOfGuestsInRoom: numOfGuests));
      notifyListeners();
      _cartRooms.forEach((element) {
        print(element.roomType);
      });
      return true;
    }
  }

  void removeRoom(int id) {
    _cartRooms.removeWhere((room) {
      return room.roomNumber == id;
    });
    notifyListeners();
  }

  void clear() {
    _cartRooms = [];
    notifyListeners();
  }
}
