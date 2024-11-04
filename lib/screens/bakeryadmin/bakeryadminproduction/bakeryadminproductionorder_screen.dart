/*
import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BakeryAdminProductionOrderScreen extends StatefulWidget {
  const BakeryAdminProductionOrderScreen({super.key});

  @override
  State<BakeryAdminProductionOrderScreen> createState() =>
      _BakeryAdminProductionOrderScreenState();
}

class _BakeryAdminProductionOrderScreenState
    extends State<BakeryAdminProductionOrderScreen> {
  // Dinamik sütun başlıkları
  final List<String> firinbaslik = ['Fırın', 'Üretim', 'ORT'];

  // Dinamik satır verileri (üretim sütunu için kontrol ekliyoruz)
  List<List<dynamic>> firinsatir = [
    ['1.Fırın', 'X', '10'],
    ['2.Fırın', 'X', '10'],
    ['3.Fırın', 'X', '10'],
    ['4.Fırın', 'X', '10'],
    ['Toplam', 'X', '10'],
  ];
  DateTime dateTime = DateTime(2024, 10, 26, 15, 14);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bakeryappbar(
        title: Text(
            "${dateTime.day.toString()}.${dateTime.month.toString()}.${dateTime.year.toString()}"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: DataTable(
              border: TableBorder.all(width: 2),
              columnSpacing: 20.0,
              columns: firinbaslik.map((column) {
                return DataColumn(
                  label: Text(
                    column,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                );
              }).toList(),
              rows: firinsatir.asMap().entries.map((entry) {
                int rowIndex = entry.key;
                List<dynamic> row = entry.value;
                return DataRow(
                  cells: row.asMap().entries.map((cellEntry) {
                    int cellIndex = cellEntry.key;
                    dynamic cellValue = cellEntry.value;

                    // Üretim sütununda (index 1) TextField ekliyoruz
                    if (cellIndex == 1 && rowIndex != firinsatir.length - 1) {
                      return DataCell(
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: TextEditingController(text: cellValue),
                          onChanged: (value) {
                            setState(() {
                              firinsatir[rowIndex][cellIndex] = value;
                            });
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none, // Gölgeyi kaldırmak için
                            contentPadding: EdgeInsets.all(
                                8), // İçerik boşluğunu ayarlamak için
                          ),
                        ),
                      );
                    } else {
                      return DataCell(
                        Text(
                          cellValue,
                        ),
                      );
                    }
                  }).toList(),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 1.6,
              height: MediaQuery.of(context).size.height / 11,
              color: Colors.blue,
              child: Text(
                "Emir Gir",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          )
        ],
      ),
    );
  }
}

*/

import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:flutter/material.dart';

class BakeryAdminProductionOrderScreen extends StatefulWidget {
  const BakeryAdminProductionOrderScreen({super.key});

  @override
  State<BakeryAdminProductionOrderScreen> createState() =>
      _BakeryAdminProductionOrderScreenState();
}

class _BakeryAdminProductionOrderScreenState
    extends State<BakeryAdminProductionOrderScreen> {
  final List<String> firinbaslik = ['Fırın', 'Üretim'];

  List<List<dynamic>> firinsatir = [
    ['1.Fırın', 'X'],
    ['2.Fırın', 'X'],
    ['3.Fırın', 'X'],
    ['4.Fırın', 'X'],
    ['Toplam', 'X'],
  ];

  DateTime dateTime = DateTime(2024, 10, 26, 15, 14);

  @override
  Widget build(BuildContext context) {
    // Ekran boyutlarına göre oranlar
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: bakeryappbar(
        title: Text(
            "${dateTime.day.toString()}.${dateTime.month.toString()}.${dateTime.year.toString()}"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: firinsatir.length - 1, // Toplam satırı hariç
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                    horizontal: screenWidth * 0.04,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.05), // Yuvarlatılmış köşeler
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  color: Colors.orangeAccent,
                                  size: screenWidth * 0.06,
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Text(
                                  firinsatir[index][0], // Fırın adı
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.05,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: screenWidth * 0.25,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: TextEditingController(
                                  text: firinsatir[index][1],
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    firinsatir[index][1] = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'Üretim',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 1.5,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.01,
                                    horizontal: screenWidth * 0.02,
                                  ),
                                ),
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Yuvarlatılmış ve ikonlu Emir Gir Butonu
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                alignment: Alignment.center,
                width: screenWidth * 0.6,
                height: screenHeight * 0.08,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(screenWidth * 0.1), // Yuvarlatılmış köşeler
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      "Emir Gir",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
