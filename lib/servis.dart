import 'package:bakeryprojectapp/marketler.dart';
import 'package:bakeryprojectapp/utilits/widgets/button.dart';
import 'package:flutter/material.dart';


class ServisPage extends StatelessWidget {
  final List<String> buttonLabels = ['S1', 'S2', 'S3', 'S4', 'S5', 'S6' , 'S7' , 'S8' , 'S9']; // Örnek buton listesi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SERVİS', // AppBar başlığı
          style: TextStyle(fontSize: 40),
        ),
        iconTheme: const IconThemeData(
          color: Colors.blue, // İkonların rengi mavi
          size: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Her satırda 3 buton olacak
            crossAxisSpacing: 10, // Butonlar arası yatay boşluk
            mainAxisSpacing: 30, // Butonlar arası dikey boşluk
            childAspectRatio: 2, // Butonların genişlik/yükseklik oranı
          ),
          itemCount: buttonLabels.length,
          itemBuilder: (context, index) {
            return custom_button1(
              context,
              buttonLabels[index],
              () {          
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MarketPage()),
                  );
              },
            );
          },
        ),
      ),
    );
  }
}