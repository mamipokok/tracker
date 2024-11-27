import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracker/pages/register_page.dart';
import 'package:tracker/service/auth_service.dart';
import 'package:tracker/widget/custom_textfield.dart';
import 'package:tracker/widget/cutom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _iconsHide = true;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.2),
            Center(
              child: Image.asset(
                'assets/images/logo_pussimpur.png',
                width: width * 0.4,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: height * 0.03,
                bottom: height * 0.01,
              ),
              child: Text(
                "MASUK DENGAN AKUN",
                style: TextStyle(
                  color: Color.fromARGB(193, 255, 255, 255),
                  fontSize: width * 0.053,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.07,
              ),
              child: Column(
                children: [
                  CustomTextfield(
                    keyboard: TextInputType.emailAddress,
                    hide: false,
                    text: "Email",
                    icon: const Icon(Icons.email),
                    controller: _emailController,
                  ),
                  SizedBox(height: height * 0.025),
                  CustomTextfield(
                    keyboard: TextInputType.visiblePassword,
                    hide: _iconsHide,
                    iconButton: IconButton(
                      onPressed: () {
                        setState(() {
                          _iconsHide = !_iconsHide;
                        });
                      },
                      icon: Icon(
                        _iconsHide
                            ? CupertinoIcons.eye_fill
                            : CupertinoIcons.eye_slash_fill,
                      ),
                    ),
                    text: "Password",
                    controller: _passwordController,
                    icon: const Icon(Icons.lock),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.04),
            CutomButton(
              horizontal: width * 0.36,
              vertical: height * 0.017,
              color: Colors.white,
              fungsi: () async {
                await AuthService().login(
                  context: context,
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                );
              },
              text: "MASUK",
            ),
            SizedBox(height: height * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Belum Punya Akun?",
                  style: TextStyle(color: Colors.white),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                  child: const Text(
                    " Buat Akun!",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
