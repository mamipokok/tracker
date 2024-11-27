import 'package:flutter/material.dart';

class DateInIndonesianManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ambil waktu saat ini
    DateTime now = DateTime.now();

    // Daftar hari dalam bahasa Indonesia
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
    String namaHari = hari[now.weekday - 1]; // weekday dimulai dari 1 (Senin)
    String namaBulan = bulan[now.month - 1]; // month dimulai dari 1 (Januari)
    String tanggal = now.day.toString();
    String tahun = now.year.toString();

    // Gabungkan menjadi satu string
    String formattedDate = '$namaHari, $tanggal $namaBulan $tahun';

    return Scaffold(
      appBar: AppBar(
        title: Text('Tanggal Manual Bahasa Indonesia'),
      ),
      body: Center(
        child: Text(
          formattedDate,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
