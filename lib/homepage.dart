/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/gider.dart';
import 'package:flutter_application_1/rapor.dart';
import 'package:flutter_application_1/screens/bakerylogin_screen.dart';
import 'package:flutter_application_1/servis.dart';
import 'package:flutter_application_1/utilits/widgets/button.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 final FirebaseAuth _auth = FirebaseAuth.instance;

    Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => BakeryLoginScreen(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          custom_button(context, 'SERVİS', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ServisPage()),
            );
          }),
          SizedBox(height: 20),
          custom_button(context, 'RAPOR', () {
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RaporPage()),
            );
          }),
          SizedBox(height: 20),
          custom_button(context, 'GİDER', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GiderPage()),
            );
          }),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.account_circle_outlined),
                  iconSize: 60,
                  color: Colors.blue,
                ),
                IconButton(
                  onPressed: () {
                    _signOut();
                  },
                  icon: Icon(Icons.exit_to_app),
                  iconSize: 60,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

*/

import 'package:bakeryprojectapp/gider.dart';
import 'package:bakeryprojectapp/models/UserModel.dart';
import 'package:bakeryprojectapp/rapor.dart';
import 'package:bakeryprojectapp/screens/bakerylogin_screen.dart';
import 'package:bakeryprojectapp/servis.dart';
import 'package:bakeryprojectapp/utilits/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;

  HomePage({required this.userModel});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => BakeryLoginScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // AppBar'daki varsayılan Drawer simgesini kaldırır
        title: Text('Ana Sayfa', style: TextStyle(fontSize: 30)),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "${widget.userModel.name}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.userModel.rolsId}",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text(
                  "Telefon: +90 555 555 55 55",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text(
                  "Konum: İstanbul",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  "Ayarlar",
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  // Ayarlar sayfasına yönlendirme kodu
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  "Çıkış Yap",
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  _signOut();
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          custom_button(context, 'SERVİS', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ServisPage()),
            );
          }),
          SizedBox(height: 20),
          custom_button(context, 'RAPOR', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RaporPage()),
            );
          }),
          SizedBox(height: 20),
          custom_button(context, 'GİDER', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GiderPage()),
            );
          }),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(Icons.account_circle_outlined),
                      iconSize: 60,
                      color: Colors.blue,
                    );
                  },
                ),
                IconButton(
                  onPressed: () {
                    _signOut();
                  },
                  icon: Icon(Icons.exit_to_app),
                  iconSize: 60,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
