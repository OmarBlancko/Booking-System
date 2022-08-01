import 'dart:convert';

import 'package:bookingsystem/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:bookingsystem/models/guest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewUser with ChangeNotifier {
  late Guest? signedUser;
  Future<Guest?> get currentUserInfo async {
    if (signedUser == null) {
    await getUserData();
    return signedUser;
    }
    else
      return signedUser;

  }
  Future<void> registerUser(Map<String, String> guestData) async {
    final user = <String, dynamic>{
      'guestId': userIdentification,
      'email': guestData['email'],
      'firstName': guestData['firstName'],
      'lastName': guestData['lastName'],
      'phoneNumber': guestData['phoneNumber']
    };
    try {
      final db = FirebaseFirestore.instance;
      await db.collection('users').doc(userIdentification).set(user);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final guestInfo = json.encode({
        'firstName': guestData['firstName'],
        'lastName': guestData['lastName'],
        'phoneNumber': guestData['phoneNumber'],
        'email': guestData['email']
      });
      prefs.setString('guestInfo', guestInfo);
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchUserData() async {
    try {
      final db = FirebaseFirestore.instance;
      final docRef = db.collection('users').doc(userIdentification);
      await docRef.get().then(
        (DocumentSnapshot doc) async {
          final data = doc.data() as Map<String, dynamic>;

          Guest snapShotData = new Guest(
              guestId: data['guestId'],
              firstName: data['firstName'],
              lastName: data['lastName'],
              phoneNumber: data['phoneNumber'],
              email: data['email']);
          final prefs = await SharedPreferences.getInstance();
          final guestInfo = json.encode({
            'firstName': snapShotData.firstName,
            'lastName': snapShotData.lastName,
            'phoneNumber': snapShotData.phoneNumber,
            'email': snapShotData.email,
          });
          prefs.setString('guestInfo', guestInfo);
          signedUser = snapShotData;
        },
        onError: (e) => print(e),
      );
    } catch (error) {
      print(error);
    }
  }

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('guestInfo') || prefs.get('guestInfo') == null) {
      print('not exist');
      fetchUserData();
      return;
    } else {
      print('exist');
      final _extractedData = json.decode(prefs.getString('guestInfo') ?? '')
          as Map<String, dynamic>;
      final Guest temp = new Guest(
          guestId: userIdentification,
          firstName: _extractedData['firstName'],
          lastName: _extractedData['lastName'],
          phoneNumber: _extractedData['phoneNumber'],
          email: _extractedData['email']);
      signedUser = temp;
    }
  }
}
