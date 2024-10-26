import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:flutter/material.dart';

class BakeryAdminReportsScreen extends StatefulWidget {
  const BakeryAdminReportsScreen({super.key});

  @override
  State<BakeryAdminReportsScreen> createState() =>
      _BakeryAdminReportsScreenState();
}

class _BakeryAdminReportsScreenState extends State<BakeryAdminReportsScreen> {
  // Dinamik sütun başlıkları (Market ve Servis başlıkları)
  final List<String> columns = ['Market','S1','S2','S3','S4','S5','S6','Toplam','Fiyat'];

  // Dinamik satır verileri
  final List<List<String>> rows = [
    ['SHELL','350','20','20','X',"X",'X','100','9500'],
    ['TOTAL','30','20','20','X',"X",'X','100','9500'],
    ['PETROL Ofisi','20','20','50','50',"X",'X','100','9500'],
    ['OPET','50','20','20','20',"X",'X','100','9500'],
    ['Toplam','150','220','520','20',"X",'X','1100','98500'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bakeryappbar(),
      body: Container(
        alignment: Alignment.topCenter,
        child: DataTable(
          border: TableBorder.all(width: 2),
          columnSpacing: 15.0,
          columns: columns.map((column) {
            return DataColumn(
              label: Text(
                column,
                
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            );
          }).toList(),
          rows: rows.map((row) {
            return DataRow(
              cells: row.map((cell) {
                return DataCell(
                  Text(cell,textAlign: TextAlign.start,),
                );
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
