import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataPersonal extends StatefulWidget {
  @override
  State<DataPersonal> createState() => _DataPersonalState();
}

class _DataPersonalState extends State<DataPersonal> {
  // Mengambil data pengguna dari Firebase Firestore
  Stream<QuerySnapshot> getUserData() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        title: Text(
          'Data Personel',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          }

          // Ambil data pengguna dari snapshot
          var users = snapshot.data!.docs;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text('No', style: TextStyle(color: Colors.white)),
                ),
                DataColumn(
                    label: Text('Nama', style: TextStyle(color: Colors.white))),
                DataColumn(
                    label:
                        Text('Pangkat', style: TextStyle(color: Colors.white))),
                DataColumn(
                    label: Text('NRP', style: TextStyle(color: Colors.white))),
                DataColumn(
                    label:
                        Text('Jabatan', style: TextStyle(color: Colors.white))),
                // DataColumn(
                //     label:
                //         Text('Email', style: TextStyle(color: Colors.white))),
              ],
              rows: users.map<DataRow>((user) {
                var userData = user.data() as Map<String, dynamic>;
                return DataRow(cells: [
                  DataCell(Text((users.indexOf(user) + 1).toString(),
                      style: TextStyle(color: Colors.white))),
                  DataCell(Text(userData['nama'] ?? '',
                      style: TextStyle(color: Colors.white))),
                  DataCell(Text(userData['pangkat'] ?? '',
                      style: TextStyle(color: Colors.white))),
                  DataCell(Text(userData['nrp'] ?? '',
                      style: TextStyle(color: Colors.white))),
                  DataCell(Text(userData['jabatan'] ?? '',
                      style: TextStyle(color: Colors.white))),
                  // DataCell(Text(userData['email'] ?? '',
                  //     style: TextStyle(color: Colors.white))),
                ]);
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
