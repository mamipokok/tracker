import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tracker/pages/login_page.dart';
import 'package:tracker/pages/page_navbar/profil/profil_page.dart';
import 'package:tracker/pages/register_page.dart';
import 'package:tracker/widget/navbar.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  Future<void> register({
    required String nama,
    required String pangkat,
    required String nrp,
    required String jabatan,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      if (nama.isEmpty) {
        Fluttertoast.showToast(msg: 'Nama wajib Diisi');
      } else if (pangkat.isEmpty) {
        Fluttertoast.showToast(msg: 'pangkat wajib Diisi');
      } else if (nrp.isEmpty) {
        Fluttertoast.showToast(msg: 'nrp wajib Diisi');
      } else if (jabatan.isEmpty) {
        Fluttertoast.showToast(msg: 'jabatan wajib Diisi');
      } else if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );
        await _fireStore.collection('users').doc(credential.user!.uid).set({
          'nama': nama.trim(),
          'pangkat': pangkat.trim(),
          'nrp': nrp.trim(),
          'jabatan': jabatan.trim(),
          'email': email.trim(),
          'password': password.trim(),
          'uid': credential.user!.uid,
        });
        Fluttertoast.showToast(msg: 'Akun berhasil di buat!!');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    } on FirebaseAuthException catch (e) {
      String pesan = '';
      if (e.code == 'weak-password') {
        pesan = 'Password Terlalu Lemah';
      } else if (e.code == 'email-already-in-use') {
        pesan = 'Email Sudah Di Gunakan';
      } else if (e.code == 'invalid-email') {
        pesan = 'Email Tidak Valid';
      } else {
        pesan = 'Email & password Tidak Boleh kosong';
      }
      Fluttertoast.showToast(
        msg: pesan,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      if (email.isEmpty) {
        Fluttertoast.showToast(msg: 'email tidak boleh kosong');
      } else if (password.isEmpty) {
        Fluttertoast.showToast(msg: 'password tidak boleh kosong');
      } else {
        await _auth.signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );
        Fluttertoast.showToast(msg: 'Anda Berhasil Login');
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Navbar()));
      }
    } on FirebaseAuthException catch (e) {
      String pesan = '';
      if (e.code == 'user-not-found') {
        pesan = 'user tidak ditemukan';
      } else if (e.code == 'wrong-password') {
        pesan = 'password salah';
      } else if (e.code == 'invalid-email') {
        pesan = 'email tidak valid';
      } else if (e.code == 'user-disabled') {
        pesan = 'Akun di nonaktifkan';
      } else if (e.code == 'weak-password') {
        pesan = 'password terlalu lemah';
      } else {
        pesan = 'kombinasi email & password tidak cocok';
      }
      Fluttertoast.showToast(
        msg: pesan,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  Future<void> keluar({required BuildContext context}) async {
    await _auth.signOut();
    await Future.delayed(Duration(seconds: 1));
    Fluttertoast.showToast(msg: 'Anda Berhasil Keluar');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
