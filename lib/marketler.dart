import 'package:bakeryprojectapp/shell.dart';
import 'package:bakeryprojectapp/utilits/widgets/button.dart';
import 'package:flutter/material.dart';
// Özel düğme widget'ını içe aktarıyor
// Shell sayfasını içe aktarıyor

class MarketPage extends StatelessWidget {
   final List<String> marketler;
 MarketPage({required this.marketler});

  final List<String> buttonLabels = [
    'SHELL',
    'AYAZLI',
    'MAT',
    'BARIŞ',
    'GÖZDE',
    'CENEVİZ',
    'ŞOK',
    'A101',
    'BİM',
    'MİGROS',
    'CARREFOURSA'
  ]; // Buton listesi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MARKETLER", // AppBar başlığı
          style: TextStyle(fontSize: 40),
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
                  MaterialPageRoute(builder: (context) => ShellPage()),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
