import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracker/service/auth_service.dart';
import 'package:tracker/widget/custom_textfield.dart';
import 'package:tracker/widget/cutom_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _namaContoller = TextEditingController();
  final TextEditingController _pangkatContoller = TextEditingController();
  final TextEditingController _nrpContoller = TextEditingController();
  final TextEditingController _jabatanContoller = TextEditingController();
  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _passwordContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.07,
              ),
              child: Column(
                children: [
                  SizedBox(height: height * 0.25),
                  CustomTextfield(
                    controller: _namaContoller,
                    icon: Icon(Icons.person_2),
                    text: "Nama",
                    hide: false,
                    keyboard: TextInputType.text,
                  ),
                  SizedBox(height: height * 0.01),
                  CustomTextfield(
                    controller: _pangkatContoller,
                    icon: Icon(CupertinoIcons.capslock_fill),
                    text: "Pangkat",
                    hide: false,
                    keyboard: TextInputType.text,
                  ),
                  SizedBox(height: height * 0.01),
                  CustomTextfield(
                    controller: _nrpContoller,
                    icon: const Icon(Icons.art_track_sharp),
                    text: "NRP",
                    hide: false,
                    keyboard: TextInputType.number,
                  ),
                  SizedBox(height: height * 0.01),
                  CustomTextfield(
                    controller: _jabatanContoller,
                    icon: const Icon(CupertinoIcons.building_2_fill),
                    text: "Jabatan",
                    hide: false,
                    keyboard: TextInputType.text,
                  ),
                  SizedBox(height: height * 0.01),
                  CustomTextfield(
                    controller: _emailContoller,
                    icon: Icon(Icons.email),
                    text: "Email",
                    hide: false,
                    keyboard: TextInputType.emailAddress,
                  ),
                  SizedBox(height: height * 0.01),
                  CustomTextfield(
                    controller: _passwordContoller,
                    icon: Icon(Icons.lock),
                    text: "Password",
                    hide: false,
                    keyboard: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: height * 0.01),
                ],
              ),
            ),
            CutomButton(
              color: Colors.white,
              horizontal: width * 0.35,
              vertical: height * 0.017,
              fungsi: () async {
                await AuthService().register(
                  nama: _namaContoller.text.trim(),
                  pangkat: _pangkatContoller.text.trim(),
                  nrp: _nrpContoller.text.trim(),
                  jabatan: _jabatanContoller.text.trim(),
                  email: _emailContoller.text.trim(),
                  password: _passwordContoller.text.trim(),
                  context: context,
                );
              },
              text: "DAFTAR",
            ),
            SizedBox(height: height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sudah Punya Akun?",
                  style: TextStyle(color: Colors.white),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    " Login Sekarang",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
