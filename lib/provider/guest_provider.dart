import 'package:flutter/cupertino.dart';
import 'package:bookingsystem/models/guest.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';
class NewUser with ChangeNotifier {

  Future<void> registerUser(Map<String, String> guestData) async {
    final newGuest = new Guest(
      guestId: DateTime.now().toString(),
      email: guestData['email'] ?? '',
      firstName: guestData['firstName'] ?? '',
      lastName: guestData['lastName'] ?? '',
      phoneNumber: guestData['phoneNumber'] ?? '',
    );
    // print(newGuest.guestId);
    try {
      final url = 'https://bookingsystem-33e33-default-rtdb.europe-west1.firebasedatabase.app/users.json';
      final response = await http.post(Uri.parse(url),body:
        json.encode({
          'guestid': newGuest.guestId,
            'firstName': newGuest.firstName,
            'lastName': newGuest.lastName,
            'email': newGuest.email,
            'phoneNumber': newGuest.phoneNumber,
        })
      );
      final id = json.decode(response.body);
      print(id['name']);
      // await DBHelper.instance.insert('guest', {
      //   'guestid': newGuest.guestId,
      //   'firstName': newGuest.firstName,
      //   'lastName': newGuest.lastName,
      //   'email': newGuest.email,
      //   'phoneNumber': newGuest.phoneNumber,
      // });
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> login() async {}
}