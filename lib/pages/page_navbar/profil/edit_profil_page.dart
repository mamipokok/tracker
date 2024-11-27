import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tracker/service/firestore_service.dart';
import 'package:tracker/widget/custom_textfield.dart';
import 'package:tracker/widget/cutom_button.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;
  final String uid;

  const EditProfilePage({required this.userData, required this.uid, Key? key})
      : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _pangkatController;
  late TextEditingController _nrpController;
  late TextEditingController _jabatanController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userData['nama']);
    _pangkatController =
        TextEditingController(text: widget.userData['pangkat']);
    _nrpController = TextEditingController(text: widget.userData['nrp']);
    _jabatanController =
        TextEditingController(text: widget.userData['jabatan']);
    _emailController = TextEditingController(text: widget.userData['email']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pangkatController.dispose();
    _nrpController.dispose();
    _jabatanController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _simpanPerubahan() async {
    if (_nameController.text.isEmpty ||
        _pangkatController.text.isEmpty ||
        _nrpController.text.isEmpty ||
        _jabatanController.text.isEmpty ||
        _emailController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Semua field wajib diisi!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return; // Keluar dari fungsi jika ada field kosong
    }
    final updatedData = {
      'nama': _nameController.text,
      'pangkat': _pangkatController.text,
      'nrp': _nrpController.text,
      'jabatan': _jabatanController.text,
      'email': _emailController.text,
    };

    await FirestoreService().updateData(widget.uid, updatedData);

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('Profile updated successfully!')),
    // );
    Fluttertoast.showToast(msg: 'Data Berhasil di update');

    Navigator.pop(context, updatedData); // Kembali ke halaman profil
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: height * 0.1),
              // CustomTextfield(
              //   controller: _emailController,
              //   icon: Icon(Icons.email),
              //   text: "Email",
              //   hide: false,
              //   keyboard: TextInputType.none,
              // ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: width * 0.18),
                  Text(
                    "Edit Profil",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.07,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.1),
              CustomTextfield(
                controller: _nameController,
                icon: Icon(Icons.person_2),
                text: "Nama",
                hide: false,
                keyboard: TextInputType.name,
              ),
              SizedBox(height: height * 0.02),
              CustomTextfield(
                controller: _pangkatController,
                icon: Icon(CupertinoIcons.capslock_fill),
                text: "Pangkat",
                hide: false,
                keyboard: TextInputType.text,
              ),
              SizedBox(height: height * 0.02),
              CustomTextfield(
                controller: _nrpController,
                icon: Icon(Icons.art_track_sharp),
                text: "NRP",
                hide: false,
                keyboard: TextInputType.number,
              ),
              SizedBox(height: height * 0.02),
              CustomTextfield(
                controller: _jabatanController,
                icon: Icon(CupertinoIcons.building_2_fill),
                text: "Jabatan",
                hide: false,
                keyboard: TextInputType.text,
              ),
              SizedBox(height: height * 0.02),
              CutomButton(
                fungsi: _simpanPerubahan,
                text: "Simpan",
                horizontal: width * 0.38,
                vertical: height * 0.018,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
