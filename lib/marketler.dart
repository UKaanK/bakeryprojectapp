import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/shell.dart';
import 'package:bakeryprojectapp/utilits/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Özel düğme widget'ını içe aktarıyor
// Shell sayfasını içe aktarıyor

class MarketPage extends StatelessWidget {
  final UserModel userModel;
  final List<String> marketler;
  final String servisKey;
  MarketPage({required this.marketler, required this.userModel,required this.servisKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "MARKETLER", // AppBar başlığı
          style:GoogleFonts.cambo(
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.blue, // İkon rengi mavi
          size: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: ListView.builder(
          itemCount: marketler.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 13.0),
              child: customButton2(context, marketler[index], () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShellPage(
                            userModel: userModel,
                            marketIsim: marketler[index],
                            servis: servisKey,
                          )),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
