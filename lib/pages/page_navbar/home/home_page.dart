import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:tracker/pages/page_navbar/home/lokasi.dart';

class HomePage extends StatefulWidget {
  @override
  _DateTimeInIndonesianManualState createState() =>
      _DateTimeInIndonesianManualState();
}

class _DateTimeInIndonesianManualState extends State<HomePage> {
  //untuk tanngal dll
  late Timer _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Update waktu setiap detik
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }
  //buat lacak lokasi

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    List<String> hari = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu'
    ];

    // Daftar bulan dalam bahasa Indonesia
    List<String> bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];

    // Ambil nama hari, tanggal, bulan, dan tahun
    String namaHari = hari[_now.weekday - 1]; // weekday dimulai dari 1 (Senin)
    String namaBulan = bulan[_now.month - 1]; // month dimulai dari 1 (Januari)
    String tanggal = _now.day.toString();
    String tahun = _now.year.toString();

    // Format jam, menit, dan detik
    String jam = _now.hour.toString().padLeft(2, '0');
    String menit = _now.minute.toString().padLeft(2, '0');
    String detik = _now.second.toString().padLeft(2, '0');

    String formatHari = '$namaHari';
    String formatTanggal = '$tanggal $namaBulan $tahun';
    String formattedTime = '$jam:$menit:$detik';
    //untuk tanggal dan lain lain sampai sini

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height * 0.075),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width * 0.5,
                height: height * 0.09,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 90, 82, 82),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${formatHari},",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.05,
                        ),
                      ),
                      Text(
                        formatTanggal,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.05,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: width * 0.01),
              Container(
                width: width * 0.35,
                height: height * 0.09,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 90, 82, 82),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: width * 0.2),
                        Text(
                          "Jam",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.05,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      formattedTime,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.065,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: width * 0.01),
          Container(
            height: height * 0.09,
            width: width * 0.85,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 90, 82, 82),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Lokasi(),
          ),

        ],
      ),
    );
  }
}

