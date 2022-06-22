import 'package:flutter/material.dart';

import '../models/room.dart';

class SingleReservation {
  late final String reservationName;
  late final List<Room> rooms;
  late final double total;
  late final String guestId;
  late final String hotelId;
  SingleReservation(this.reservationName, this.rooms, this.total);
}

class ReservationsCart with ChangeNotifier {
  List<SingleReservation> _reservations = [];

  List<SingleReservation> get reservations {
    return [..._reservations];
  }

  void addRoom(Room newRoom) {
    _reservations[1].rooms.add(newRoom);
  }
}
