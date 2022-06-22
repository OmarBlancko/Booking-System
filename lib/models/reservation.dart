import 'package:flutter/cupertino.dart';

class RoomReservation {
  late final String reservationNumber;
  late final String bookingName;
  late final String hotelId;
  late final String guestId;
  late final String roomType;
  late final int numberOfPersons;
  late final String? startDate;
  late final String? leaveDate;
  late final List<String> roomsId;
  RoomReservation(
      {required this.reservationNumber,
      required this.bookingName,
      required this.hotelId,
      required this.guestId,
      required this.roomType,
      required this.numberOfPersons,
      required this.startDate,
      required this.leaveDate});
}
class ReservationList with ChangeNotifier {
 late Map<String,RoomReservation> _reservationList ={};
}