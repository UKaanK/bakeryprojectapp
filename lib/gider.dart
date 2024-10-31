/*

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
//BU KISIM YAKIT , DİĞER AÇIKLAMALAR(TEXTFİELD HALİNDE) VE TUTAR OLAN KISIMLI HALİ
*/




/*
import 'package:flutter/material.dart';

class GiderPage extends StatefulWidget {
  @override
  _GiderPageState createState() => _GiderPageState();
}

class _GiderPageState extends State<GiderPage> {
  final TextEditingController yakitController = TextEditingController();
  final TextEditingController tutarController = TextEditingController();

  // Seçilen açıklama değişkeni
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GİDER",
          style: TextStyle(fontSize: 40),
        ),
        iconTheme: IconThemeData(color: Colors.blue, size: 30),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 60,
              child: Row(
                children: [
                  Text(
                    "YAKIT:",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 6,
                    child: TextField(
                      controller: yakitController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '0',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 5, 5, 5), width: 2.0),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
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
            SizedBox(height: 20),
            Divider(color: Colors.black, thickness: 4.5),
            SizedBox(height: 20),
            // Checkbox için bölüm
            
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [             
                  Text("DİĞER GİDERLER:", style: TextStyle(fontSize: 24)),
                ],),
                RadioListTile<String>(
                  title: Text("ŞÖFÖR İHTİYACI"),
                  value: "Açıklama 1",
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text("ARAÇ İHTİYACI"),
                  value: "Açıklama 2",
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text("ARAÇ BAKIMI"),
                  value: "Açıklama 3",
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text("YEMEK"),
                  value: "Açıklama 4",
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text("DİĞER"),
                  value: "Açıklama 5",
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 60,
              child: Row(
                children: [
                  Text(
                    "TUTAR:",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: tutarController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '0',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  print("Girilen Tutar: ${tutarController.text}");
                  print("Seçilen Açıklama: $selectedOption");
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


//BU KISIM YAKIT DİĞER GİDERLER (CHECKBOX LI HALİ) VE TUTAR OLAN KISIMLA HALİ.
*/


import 'package:flutter/material.dart';

class GiderPage extends StatefulWidget {
  @override
  _GiderPageState createState() => _GiderPageState();
}

class _GiderPageState extends State<GiderPage> {
  final TextEditingController yakitController = TextEditingController();
  final TextEditingController tutarController = TextEditingController();
  List<String> selectedOptions = [];
  bool showAdditionalOptions = false;

  void _onYakitGir() {
    if (yakitController.text.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Ek Gider Var mı?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(
              "Araç için başka bir gider var mı?",
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(
                      "Hayır",
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text(
                      "Evet",
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    ),
                    onPressed: () {
                      setState(() {
                        showAdditionalOptions = true;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    }
  }

  void _onOptionSelected(String option, bool selected) {
    setState(() {
      if (selected) {
        selectedOptions.add(option);
      } else {
        selectedOptions.remove(option);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GİDER",
          style: TextStyle(fontSize: 40),
        ),
        iconTheme: IconThemeData(color: Colors.blue, size: 30),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 60,
              child: Row(
                children: [
                  Text(
                    "YAKIT:",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 6,
                    child: TextField(
                      controller: yakitController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '0',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 5, 5, 5), width: 2.0),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _onYakitGir,
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
            if (showAdditionalOptions) ...[
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("DİĞER GİDERLER:", style: TextStyle(fontSize: 24)),
                      ],
                    ),
                    CheckboxListTile(
                      title: Text("ŞÖFÖR İHTİYACI"),
                      value: selectedOptions.contains("ŞÖFÖR İHTİYACI"),
                      onChanged: (bool? value) {
                        _onOptionSelected("ŞÖFÖR İHTİYACI", value!);
                      },
                    ),
                    CheckboxListTile(
                      title: Text("ARAÇ İHTİYACI"),
                      value: selectedOptions.contains("ARAÇ İHTİYACI"),
                      onChanged: (bool? value) {
                        _onOptionSelected("ARAÇ İHTİYACI", value!);
                      },
                    ),
                    CheckboxListTile(
                      title: Text("ARAÇ BAKIMI"),
                      value: selectedOptions.contains("ARAÇ BAKIMI"),
                      onChanged: (bool? value) {
                        _onOptionSelected("ARAÇ BAKIMI", value!);
                      },
                    ),
                    CheckboxListTile(
                      title: Text("YEMEK"),
                      value: selectedOptions.contains("YEMEK"),
                      onChanged: (bool? value) {
                        _onOptionSelected("YEMEK", value!);
                      },
                    ),
                    CheckboxListTile(
                      title: Text("DİĞER"),
                      value: selectedOptions.contains("DİĞER"),
                      onChanged: (bool? value) {
                        _onOptionSelected("DİĞER", value!);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60,
                child: Row(
                  children: [
                    Text(
                      "TUTAR:",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: tutarController,
                        keyboardType: TextInputType.number,
                        enabled: selectedOptions.isNotEmpty,
                        decoration: InputDecoration(
                          hintText: '0',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 55,
                child: ElevatedButton(
                  onPressed: selectedOptions.isEmpty
                      ? null
                      : () {
                          print("Girilen Tutar: ${tutarController.text}");
                          print("Seçilen Açıklamalar: $selectedOptions");
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedOptions.isEmpty
                        ? Colors.grey
                        : Colors.blue,
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
          ],
        ),
      ),
    );
  }
}
