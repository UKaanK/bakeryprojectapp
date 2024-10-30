import 'package:flutter/material.dart';

class GiderPage extends StatelessWidget {
  // Controller'lar kullanıcıdan alınacak verileri saklamak için tanımlandı
  final TextEditingController yakitController = TextEditingController();
  final TextEditingController aciklamaController = TextEditingController();
  final TextEditingController tutarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Sayfa başlığını ve AppBar stilini ayarlar
        title: Text(
          "GİDER",
          style: TextStyle(fontSize: 40),
        ),
        iconTheme: IconThemeData(color: Colors.blue, size: 30),
      ),
      // İçeriği 16.0 birim boşlukla sarmalar
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // YAKIT girişi bölümü
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 60,
              child: Row(
                children: [
                  // "YAKIT:" metni
                  Text(
                    "YAKIT:",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                      width: 10), // YAKIT metni ve TextField arasında boşluk
                  Expanded(
                    flex: 6,
                    child: TextField(
                      controller: yakitController, // YAKIT girişini saklar
                      keyboardType: TextInputType.number, // Sadece sayı girişi
                      decoration: InputDecoration(
                        hintText: '0',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 5, 5, 5), width: 2.0),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // TextField ve "GİR" butonu arası boşluk
                  // "GİR" butonu - YAKIT girişini onaylar
                  ElevatedButton(
                    onPressed: () {
                      print("Girilen Yakıt: ${yakitController.text}");
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(60, 55),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    child: Text(
                      "GİR",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // YAKIT girişi ve divider arasındaki boşluk
            Divider(
              color: Colors.black,
              thickness: 4.5, // Bölüm çizgisi
            ),
            SizedBox(
                height:
                    20), // Divider ve DİĞER AÇIKLAMA girişi arasındaki boşluk
            // DİĞER AÇIKLAMA girişi bölümü
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 60,
              child: Row(
                children: [
                  // "DİĞER AÇIKLAMA:" metni
                  Text(
                    "DİĞER AÇIKLAMA:",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 10), // Metin ve TextField arasında boşluk
                  Expanded(
                    child: TextField(
                      controller:
                          aciklamaController, // Açıklama girişini saklar
                      keyboardType: TextInputType.text, // Yazı girişi
                      decoration: InputDecoration(
                        hintText: 'Açıklama girin',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // DİĞER AÇIKLAMA ve TUTAR arasında boşluk
            // TUTAR girişi bölümü
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 60,
              child: Row(
                children: [
                  // "TUTAR:" metni
                  Text(
                    "TUTAR:",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 10), // Metin ve TextField arasında boşluk
                  Expanded(
                    child: TextField(
                      controller: tutarController, // Tutar girişini saklar
                      keyboardType: TextInputType.number, // Sadece sayı girişi
                      decoration: InputDecoration(
                        hintText: '0',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // TUTAR ve alt GİR butonu arasındaki boşluk
            // Alt GİR butonu - Açıklama ve tutarı onaylar
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  print("Girilen Açıklama: ${aciklamaController.text}");
                  print("Girilen Tutar: ${tutarController.text}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                child: Text(
                  "GİR",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
