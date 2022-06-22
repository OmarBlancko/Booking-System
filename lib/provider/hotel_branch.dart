import 'package:flutter/material.dart';
import 'package:bookingsystem/models/hotel.dart';
import 'package:bookingsystem/helper/DBHelper.dart';

class HotelBranch with ChangeNotifier {
  List<Hotel> _hotels = [];
  List<Hotel> get hotels {
    return [..._hotels];
  }

  void setHotels(List<Hotel> h) {
    _hotels = h;
  }

  final dbHelper = DBHelper.instance;

  Future<List<Hotel>> getAndFetchHotels() async {
    try {
      // final instance = db.getInstance();
      final dataList = await dbHelper.getData('Hotel');
      _hotels = dataList
          .map((hotel) => Hotel(
              hotelId: hotel['hotelid'],
              location: hotel['location'],
              address: hotel['address'],
              numOfRooms: hotel['numOfRooms']))
          .toList();
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return [..._hotels];

  }

  Hotel getHotelByID(String id) {
    return _hotels.firstWhere((hotel) => hotel.hotelId == id);
  }

  Hotel getHotelByName(String name) {
    return _hotels.firstWhere((hotel) => hotel.location == name);
  }
}
