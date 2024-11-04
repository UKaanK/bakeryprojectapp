import 'package:bakeryprojectapp/models/UserModel.dart';
import 'package:bakeryprojectapp/models/regionmodel.dart';
import 'package:bakeryprojectapp/screens/bakeryadmin/bakeryadmindistribution_screen.dart';
import 'package:bakeryprojectapp/screens/bakeryadmin/bakeryadminproduction/bakeryadminproduction_screen.dart';
import 'package:bakeryprojectapp/screens/bakeryadmin/bakeryadminservicereports/bakeryadminregion_screen.dart';
import 'package:bakeryprojectapp/screens/bakerylogin_screen.dart';
import 'package:bakeryprojectapp/services/regionservices.dart';
import 'package:bakeryprojectapp/utilits/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BakeryAdminScreen extends StatefulWidget {
  final UserModel userModel;
  const BakeryAdminScreen({super.key, required this.userModel});

  @override
  State<BakeryAdminScreen> createState() => _BakeryAdminScreenScreenState();
}

class _BakeryAdminScreenScreenState extends State<BakeryAdminScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RegionService _regionService = RegionService();
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
  void initState() {
    super.initState();
    print(widget.userModel.rolsId);
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
                  "${widget.userModel.telefonNo}",
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
          custom_button(context, 'RAPOR',() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BakeryAdminRegionScreen(
                              userModel: widget.userModel,
                            ),),
            );
          }),
          SizedBox(height: 20),
          custom_button(context, 'ÜRETİM', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BakeryAdminProductionScreen(userModel: widget.userModel,)),
            );
          }),
          SizedBox(height: 20),
          custom_button(context, 'DAĞITIM', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BakeryAdminDistributionScreen()),
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














