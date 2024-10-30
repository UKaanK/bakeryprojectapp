
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
