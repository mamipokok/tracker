import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tracker/pages/page_navbar/profil/edit_profil_page.dart';
import 'package:tracker/service/auth_service.dart';
import 'package:tracker/service/firestore_service.dart';
import 'package:tracker/widget/cutom_button.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _firestoreService.ambilDataUser(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No user data found.'));
          }

          final userData = snapshot.data!;
          return ListView(
            children: [
              SizedBox(height: height * 0.01),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Profil",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.06,
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                    CircleAvatar(radius: width * 0.17),
                    SizedBox(height: height * 0.03),
                    Text(
                      "${userData['nama']}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.045,
                      ),
                    ),
                    Text(
                      "${userData['email']}",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 205, 197, 197),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    CutomButton(
                      fungsi: () async {
                        final updateData = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProfilePage(userData: userData, uid: uid),
                          ),
                        );

                        if (updateData != null) {
                          setState(() {
                            userData.addAll(updateData);
                          });
                        }
                      },
                      text: "Edit Profil",
                      horizontal: width * 0.18,
                      vertical: height * 0.014,
                      color: Colors.white,
                    ),
                    SizedBox(height: height * 0.05),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(CupertinoIcons.capslock_fill),
                      ),
                      title: Text(
                        "Pangkat",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "${userData['pangkat']}",
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          final updateData = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditProfilePage(userData: userData, uid: uid),
                            ),
                          );

                          if (updateData != null) {
                            setState(() {
                              userData.addAll(updateData);
                            });
                          }
                        },
                        icon: Icon(
                          Icons.edit,
                          size: width * 0.07,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.art_track_sharp),
                      ),
                      title: Text(
                        "NRP",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "${userData['nrp']}",
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          final updateData = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditProfilePage(userData: userData, uid: uid),
                            ),
                          );

                          if (updateData != null) {
                            setState(() {
                              userData.addAll(updateData);
                            });
                          }
                        },
                        icon: Icon(
                          Icons.edit,
                          size: width * 0.07,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(CupertinoIcons.building_2_fill),
                      ),
                      title: Text(
                        "Jabatan",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "${userData['jabatan']}",
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          final updateData = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditProfilePage(userData: userData, uid: uid),
                            ),
                          );

                          if (updateData != null) {
                            setState(() {
                              userData.addAll(updateData);
                            });
                          }
                        },
                        icon: Icon(
                          Icons.edit,
                          size: width * 0.07,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        // left: width * 0.05,
                        // right: width * 0.05,
                        top: height * 0.1,
                      ),
                      child: Divider(
                        color: const Color.fromARGB(103, 158, 158, 158),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      AuthService().keluar(context: context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.square_arrow_right,
                          color: Colors.grey,
                        ),
                        SizedBox(width: width * 0.03),
                        Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
