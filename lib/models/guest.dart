import 'dart:convert';

class Guest  {
  late final String guestId;
  late final String firstName;
  late final String lastName;
  late final String phoneNumber;
  late final String email;
  final String? reservationNumber;
  Guest(
      {required this.guestId,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.email,
      this.reservationNumber})
      ;
}

