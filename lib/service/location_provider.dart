import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentLocation;
  List<Placemark>? _placemark;

  Position? get currentLocation => _currentLocation;
  List<Placemark>? get placemark => _placemark;

  Future<void> getLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Layanan lokasi tidak aktif');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Izin lokasi ditolak');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Izin lokasi ditolak selamanya');
      }

      _currentLocation = await Geolocator.getCurrentPosition();
      _placemark = await placemarkFromCoordinates(
        _currentLocation!.latitude,
        _currentLocation!.longitude,
      );
      notifyListeners(); // Memberitahukan bahwa data telah diperbarui
    } catch (e) {
      print("Error mendapatkan lokasi: $e");
      throw Exception("Error mendapatkan lokasi: $e");
    }
  }
}
