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

import 'package:bakeryprojectapp/models/bakerymodel.dart';
import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/services/bakeryservices.dart';
import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:flutter/material.dart';

class BakeryAdminProductionOrderScreen extends StatefulWidget {
  final UserModel userModel;
  const BakeryAdminProductionOrderScreen({super.key, required this.userModel});

  @override
  State<BakeryAdminProductionOrderScreen> createState() =>
      _BakeryAdminProductionOrderScreenState();
}

class _BakeryAdminProductionOrderScreenState
    extends State<BakeryAdminProductionOrderScreen> {
  final BakeryServices _bakeryServices = BakeryServices();
  List<BakeryModel> bakeryList = [];
  List<Map<String, dynamic>> firinsatir = []; 

  @override
  void initState() {
    super.initState();
    fetchBakeryData(); 
  }

  Future<void> fetchBakeryData() async {
    try {
      var bakeries =
          await _bakeryServices.getAllBakeries(widget.userModel.rolsId);

      if (bakeries == null || bakeries.isEmpty) {
        throw Exception("Fırın verileri bulunamadı.");
      }

      setState(() {
        bakeryList = bakeries;
        // Create dynamic list to hold bakery names and their respective production values
        firinsatir = bakeryList.map((bakery) {
          return {
            'firinIsmi': bakery.firinIsmi,
            'ekmekSayisi': TextEditingController(), // Each bakery gets its own TextEditingController
          };
        }).toList();
      });
      print(firinsatir);
    } catch (e) {
      print("Hata: $e");
    }
  }

  DateTime dateTime = DateTime(2024, 10, 26, 15, 14);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("${dateTime.day}.${dateTime.month}.${dateTime.year}"),
        centerTitle: true,
      ),
      body: firinsatir.isEmpty
          ? Center(
              child: CircularProgressIndicator()) 
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: firinsatir.length, 
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.01,
                          horizontal: screenWidth * 0.04,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.05),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        firinsatir[index]
                                            ['firinIsmi'], 
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
                                      controller: firinsatir[index]
                                          ['ekmekSayisi'], // Use the specific controller for each bakery
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'Üretim',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade400,
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.04),
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                  child: GestureDetector(
                    onTap: () {
                      firinsatir.forEach((bakery) {
                        _bakeryServices.updateEkmekSayisi(
                          widget.userModel.rolsId,
                          bakery['firinIsmi'],
                          "${dateTime.day}.${dateTime.month}.${dateTime.year}",
                          bakery['ekmekSayisi'].text, // Access the text value of each specific controller
                        );
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(screenWidth * 0.1),
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

