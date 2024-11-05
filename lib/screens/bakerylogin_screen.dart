/*
import 'dart:ui';

import 'package:bakeryprojectapp/homepage.dart';
import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/screens/bakeryadmin/bakeryadminmain_screen.dart';
import 'package:bakeryprojectapp/services/UserServices.dart';
import 'package:flutter/material.dart';


class BakeryLoginScreen extends StatefulWidget {
  const BakeryLoginScreen({
    super.key,
  });

  @override
  State<BakeryLoginScreen> createState() => _BakeryLoginScreenState();
}

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
UserService _userService = UserService();

class _BakeryLoginScreenState extends State<BakeryLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd3effb),
      body: Stack(
        children: [
          /////////// ******* BackGround Section ****** //////////
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(30)),
                        gradient: LinearGradient(colors: [
                          Color(0xff48c6f9),
                          Color(0xff58e0aa),
                        ]),
                      ),
                    ),
                    Positioned(
                      left: -100,
                      top: -50,
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.55,
                        width: MediaQuery.sizeOf(context).width + 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color(0xff1578f8),
                              Color(0xff44c5ff),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(),
              )
            ],
          ),
          ///////// ****** Glass Effect with Login UI ****** ///////////
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
              const Text(
                "Hoş Geldiniz!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 400,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white.withOpacity(0.1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            const Center(
                                child: Text(
                              "Giriş",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white),
                            )),
                            const Spacer(),
                            const Text(
                              "E-posta",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.white)),
                              child: TextFormField(
                                controller: _emailController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.mail,
                                    color: Color(0xff4ac8f4),
                                  ),
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              "Şifre",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.white)),
                              child: TextFormField(
                                controller: _passwordController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.lock,
                                    color: Color(0xff4ac8f4),
                                  ),
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                _login();
                              },
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: const Color(0xff5bdeac),
                                    borderRadius: BorderRadius.circular(30)),
                                alignment: Alignment.center,
                                child: const Text("Giriş Yap",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            const Spacer(),
                            const Center(
                                child: Text(
                              "",
                              style: TextStyle(color: Color(0xff1576fc)),
                            )),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _login() async {
    String enteredEmail = _emailController.text.trim();
    String enteredSifre = _passwordController.text.trim();
    print(enteredSifre);
    print(enteredEmail);

    try {
      final UserService _userService = UserService();
      final UserModel? _userModel =
          await _userService.login(enteredEmail, enteredSifre);

      if (_userModel != null) {
        if (_userModel.pwd == enteredSifre) {
          if (_userModel.roles == "admin") {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => BakeryAdminScreen(userModel: _userModel),
              ),
              (route) => false,
            );
          }
          else{
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(userModel: _userModel,),
              ),
              (route) => false,
            );
          }
          print(_userModel.roles);
        } else {
          _showError("Hatalı Şifre");
        }
      } else {
        _showError("Hesap Bulunamadı");
      }
    } catch (e) {
      _showError("Hata: $e");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

*/

import 'dart:ui';

import 'package:bakeryprojectapp/homepage.dart';
import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/screens/bakeryadmin/bakeryadminmain_screen.dart';
import 'package:bakeryprojectapp/services/UserServices.dart';
import 'package:flutter/material.dart';

class BakeryLoginScreen extends StatefulWidget {
  const BakeryLoginScreen({
    super.key,
  });

  @override
  State<BakeryLoginScreen> createState() => _BakeryLoginScreenState();
}

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
UserService _userService = UserService();

class _BakeryLoginScreenState extends State<BakeryLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD3B8AE), // Kahverengi tonunda arka plan
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(30)),
                        gradient: LinearGradient(colors: [
                          Color(0xff8E6A57),
                          Color(0xffB8977E),
                        ]),
                      ),
                    ),
                    Positioned(
                      left: -100,
                      top: -50,
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.55,
                        width: MediaQuery.sizeOf(context).width + 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color(0xffD8A48F),
                              Color(0xff8E6A57),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.local_pizza, // Alternatif olarak kahverengi tema uyumlu ikon
                color: Colors.brown,
                size: 60,
              ),
              const Text(
                "Fırına Hoş Geldiniz!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white),
              ),
              const SizedBox(               
                height: 20,
              ),
              Container(
                height: 400,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white.withOpacity(0.1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            const Center(
                                child: Text(
                              "Giriş",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white),
                            )),
                            const Spacer(),
                            const Text(
                              "E-posta",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.white)),
                              child: TextFormField(
                                controller: _emailController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.mail,
                                    color: Color(0xff8E6A57), // Kahverengi tonunda ikon
                                  ),
                                  hintText: "E-posta adresinizi girin",
                                  hintStyle: TextStyle(color: Colors.white70),
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              "Şifre",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.white)),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.lock,
                                    color: Color(0xff8E6A57),
                                  ),
                                  hintText: "Şifrenizi girin",
                                  hintStyle: TextStyle(color: Colors.white70),
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                _login();
                              },
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: const Color(0xff8E6A57),
                                    borderRadius: BorderRadius.circular(30)),
                                alignment: Alignment.center,
                                child: const Text("Giriş Yap",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _login() async {
    String enteredEmail = _emailController.text.trim();
    String enteredSifre = _passwordController.text.trim();

    try {
      final UserService _userService = UserService();
      final UserModel? _userModel =
          await _userService.login(enteredEmail, enteredSifre);

      if (_userModel != null) {
        if (_userModel.pwd == enteredSifre) {
          if (_userModel.roles == "admin") {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => BakeryAdminScreen(userModel: _userModel),
              ),
              (route) => false,
            );
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(userModel: _userModel),
              ),
              (route) => false,
            );
          }
        } else {
          _showError("Hatalı Şifre");
        }
      } else {
        _showError("Hesap Bulunamadı");
      }
    } catch (e) {
      _showError("Hata: $e");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
