import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:flutter/material.dart';


class BakeryAdminDistributionScreen extends StatefulWidget {
  const BakeryAdminDistributionScreen({super.key});

  @override
  State<BakeryAdminDistributionScreen> createState() => _BakeryAdminDistributionScreenState();
}

class _BakeryAdminDistributionScreenState extends State<BakeryAdminDistributionScreen> {
  // Bölge listesi
  List<String> region = ["Ümraniye", "Çekmeköy", "Sultanbeyli", "Samandıra"];
  DateTime dateTime = DateTime(2024, 10, 26, 15, 14);

  // Dinamik sütun başlıkları
  final List<String> firinbaslik = [
    '1.F',
    '2.F',
    '3.F',
    '4.F',
    'Toplam',
  ];

  // Dinamik satır verileri
  final List<List<String>> firinsatir = [
    ['10', '20', '30', '210'],
    ['10', '20', '30', '210'],
    ['10', '20', '30', '210'],
    ['10', '20', '30', '210'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bakeryappbar(
        centerTitle: true,
        title: Text(
          "${dateTime.day.toString()}.${dateTime.month.toString()}.${dateTime.year.toString()}",
        ),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: DataTable(
              border: TableBorder.all(width: 2),
              columnSpacing: 20.0,
              columns: region.map((column) {
                return DataColumn(
                  label: Text(
                    column,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
              rows: firinsatir.map((row) {
                return DataRow(
                  cells: row.map((cell) {
                    return DataCell(
                      Text(
                        cell,
                        textAlign: TextAlign.start,
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
