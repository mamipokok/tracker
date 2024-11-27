import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/service/location_provider.dart';

class Lokasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final locationProvider = Provider.of<LocationProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.location_on,
          color: Colors.white,
          size: width * 0.15,
        ),
        locationProvider.currentLocation == null
            ? Text(
                "Lokasi belum tersedia",
                style: TextStyle(color: Colors.white),
              )
            : Text(
                '${locationProvider.placemark?[0].locality},\n'
                '${locationProvider.placemark?[0].administrativeArea}, '
                '${locationProvider.placemark?[0].country}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
        SizedBox(width: width * 0.02),
        InkWell(
          onTap: () async {
            await locationProvider.getLocation();
          },
          child: Container(
            height: height * 0.05,
            width: width * 0.23,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                "lacak",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
