enum Type {
  single,
  double,
  suite,
}

class Room {
  late final int roomNumber;
  late final String hotelId;
  int status = 0;
  late final String roomType;
  late final double roomPrice;
  late final String? reservationNumber;
  late final String? guestId;
  late final int? numOfGuestsInRoom;
  late final DateTime? startDate;
  late final DateTime? endDate;
  Room({
    required this.roomNumber,
    required this.hotelId,
    required this.status,
    required this.roomType,
    required this.roomPrice,
    this.reservationNumber,
    this.guestId,
    this.startDate,
    this.endDate,
    this.numOfGuestsInRoom,
  });
}
