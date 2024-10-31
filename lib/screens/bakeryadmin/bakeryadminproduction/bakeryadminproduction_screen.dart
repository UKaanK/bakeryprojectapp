import 'package:bakeryprojectapp/models/UserModel.dart';
import 'package:bakeryprojectapp/models/bakerymodel.dart';
import 'package:bakeryprojectapp/models/regionmodel.dart';
import 'package:bakeryprojectapp/screens/bakeryadmin/bakeryadminproduction/bakeryadminproductionorder_screen.dart';
import 'package:bakeryprojectapp/services/bakeryservices.dart';
import 'package:bakeryprojectapp/services/regionservices.dart';
import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:flutter/material.dart';

class BakeryAdminProductionScreen extends StatefulWidget {
  final UserModel userModel;
  const BakeryAdminProductionScreen({super.key,required this.userModel});

  @override
  State<BakeryAdminProductionScreen> createState() =>
      _BakeryAdminProductionScreenState();
}

class _BakeryAdminProductionScreenState
    extends State<BakeryAdminProductionScreen> {
  final BakeryServices _bakeryServices = BakeryServices();
  final RegionService _regionService = RegionService();
  List<String> regionNames = []; // Bölge isimlerini tutacak liste

  final String regionName = "Samandıra"; // Örneğin "RegionA"
  List<BakeryModel> bakeryList = [];
  @override
  void initState() {
    super.initState();
    fetchBakeryData();
  }

  Future<void> fetchBakeryData() async {
    var data = await _bakeryServices.getBakeryData(widget.userModel.rolsId, regionName);

    setState(() {
      bakeryList = data;
    });
  }

   // Verileri çekme ve güncelleme fonksiyonu
  void fetchRegions() async {
    List<RegionModel> regions =
        await _regionService.getRegions(widget.userModel.rolsId);
    setState(() {
      regionNames = regions.map((region) => region.regionName).toList();
    });
    print(regionNames);
  }
  // Dinamik sütun başlıkları (Market ve Servis başlıkları)
  final List<String> columns = [
    'FIRIN',
    'EKMEK',
  ];

  // Dinamik satır verileri
  final List<List<String>> rows = [
    [
      'DEVİR',
      'X',
    ],
    [
      '1.FIRIN',
      '30',
    ],
    ['2.FIRIN ', "50"],
    [
      '3.FIRIN',
      '50',
    ],
    [
      '4.FIRIN',
      '150',
    ],
    [
      'Toplam',
      '150',
    ],
  ];
  // Dinamik sütun başlıkları
  final List<String> firinbaslik = [
    'Tarih',
    '1.F',
    '2.F',
    '3.F',
    '4.F',
    "Toplam"
  ];
  // Dinamik satır verileri
  final List<List<String>> firinsatir = [
    ['26.10', 'X', "10", "20", "30", "210"],
    ['26.10', 'X', "10", "20", "30", "210"],
    ['26.10', 'X', "10", "20", "30", "210"],
    ['26.10', 'X', "10", "20", "30", "210"],
  ];
  DateTime dateTime = DateTime(2024, 10, 26, 15, 14);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bakeryappbar(
        centerTitle: true,
        title: Text(
            "${dateTime.day.toString()}.${dateTime.month.toString()}.${dateTime.year.toString()}"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: DataTable(
              border: TableBorder.all(width: 2),
              columnSpacing: 20.0,
              columns: columns.map((column) {
                return DataColumn(
                  label: Text(
                    column,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                );
              }).toList(),
              rows: bakeryList.map((row) {
                return DataRow(cells: [
                  DataCell(Text(row.firinIsmi)),
                  DataCell(Text(row.ekmekFiyati.toString())),
                ]);
              }).toList(),
            ),
          ),
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
          Text(
            "ORT. ÜRETİLMESİ GEREKEN EKMEK:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 11,
              color: Colors.blue,
              child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BakeryAdminProductionOrderScreen(),
                      )),
                  child: Text(
                    "ÜRETİM EMRİ GİR",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )))
        ],
      ),
    );
  }
}
