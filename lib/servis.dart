import 'package:bakeryprojectapp/marketler.dart';
import 'package:bakeryprojectapp/utilits/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/usermodel.dart';

class ServisPage extends StatelessWidget {
  final UserModel userModel;

  ServisPage({required this.userModel});

  @override
  Widget build(BuildContext context) {
    // Servis anahtarlarını sıralıyoruz
    final sortedServisKeys = userModel.servis.keys.toList()..sort();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SERVİS',
         style:GoogleFonts.aDLaMDisplay(
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.blue,
          size: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 30,
            childAspectRatio: 2,
          ),
          itemCount: sortedServisKeys.length,
          itemBuilder: (context, index) {
            // Sıralı anahtarlarla `servisKey` ve `marketler` alınıyor
            String servisKey = sortedServisKeys[index];
            List<String> marketler = userModel.servis[servisKey]!;

            return custom_button1(
              context,
              servisKey,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MarketPage(
                      marketler: marketler,
                      userModel: userModel,
                      servisKey: servisKey,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
