/*
import 'package:bakeryprojectapp/models/bakerymodel.dart';
import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/services/bakeryservices.dart';
import 'package:bakeryprojectapp/services/regionservices.dart';
import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:flutter/material.dart';
import 'package:bakeryprojectapp/models/regionmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BakeryAdminDistributionScreen extends StatefulWidget {
  final UserModel userModel;
  const BakeryAdminDistributionScreen({super.key, required this.userModel});

  @override
  State<BakeryAdminDistributionScreen> createState() =>
      _BakeryAdminDistributionScreenState();
}

class _BakeryAdminDistributionScreenState
    extends State<BakeryAdminDistributionScreen> {
  final BakeryServices _bakeryServices = BakeryServices();
  List<BakeryModel> bakeryList = [];
  List<String> firinbaslik = [];
  List<List<String>> firinsatir = [];

  late Future<void> _bakeryDataFuture;
  DateTime selectedDate = DateTime.now();
  double ortalamaEkmek = 0.0;

  @override
  void initState() {
    super.initState();
    _bakeryDataFuture = fetchBakeryData();
  }

  Future<List<BakeryModel>> fetchBakeryData() async {
    try {
      var bakeries =
          await _bakeryServices.getAllBakeries(widget.userModel.rolsId);

      if (bakeries == null || bakeries.isEmpty) {
        throw Exception("Fırın verileri bulunamadı.");
      }

      setState(() {
        bakeryList = bakeries;
        firinbaslik = ['Tarih'];
        for (var bakery in bakeryList) {
          firinbaslik.add(bakery.firinIsmi);
        }

        updateTableData();
      });
      return bakeries;
    } catch (e) {
      print("Hata: $e");
      return [];
    }
  }

  void updateTableData() {
    firinsatir.clear();

    // Seçilen tarihten itibaren 4 haftalık veriyi hesapla ve tabloya ekle
    for (int i = 0; i < 4; i++) {
      DateTime date = selectedDate.subtract(Duration(days: i * 7));
      String formattedDate = DateFormat('dd.MM.yyyy').format(date);

      // Tarih satırı ile başlayıp, ekmek sayılarını ekliyoruz
      List<String> row = [formattedDate];
      for (var bakery in bakeryList) {
        var serviceData = bakery.getEkmekSayisiByDate(formattedDate);
        if (serviceData != null && serviceData.containsKey('ekmek_sayisi')) {
          row.add(serviceData['ekmek_sayisi'].toString());
        } else {
          row.add('-');
        }
      }

      // Başlık sayısıyla eşleşecek şekilde satır uzunluğunu kontrol et
      while (row.length < firinbaslik.length) {
        row.add('-'); // Eksik hücreleri doldurmak için boş değer ekleyin
      }

      firinsatir.add(row);
    }

    // Son bir haftalık ortalama ekmek sayısını hesapla
    ortalamaEkmek = calculateWeeklyAverage();
    // Ortalamayı gösteren bir yer ekleyelim (örneğin bir değişken ya da ekranda bir metin)
    print("Son bir haftalık ortalama ekmek sayısı: $ortalamaEkmek");
  }

  double calculateWeeklyAverage() {
    double totalEkmekSayisi = 0.0;
    double totalDevirEkmekSayisi = 0.0;

    // Son 1 haftanın toplam ekmek sayısını ve devir ekmek sayısını hesapla
    for (int day = 0; day < 7; day++) {
      DateTime date = selectedDate.subtract(Duration(days: day));
      String formattedDate = DateFormat('dd.MM.yyyy').format(date);

      for (var bakery in bakeryList) {
        var serviceData = bakery.getEkmekSayisiByDate(formattedDate);
        if (serviceData != null) {
          if (serviceData.containsKey('ekmek_sayisi')) {
            totalEkmekSayisi += serviceData['ekmek_sayisi']!.toDouble();
          }
          if (serviceData.containsKey('devir_ekmek_sayisi')) {
            totalDevirEkmekSayisi +=
                serviceData['devir_ekmek_sayisi']!.toDouble();
          }
        }
      }
    }

    // Haftalık farkı hesapla
    var difference = totalEkmekSayisi - totalDevirEkmekSayisi;

    // Farkı 7'ye bölerek ortalamayı hesapla
    var averageDifference = difference / 7;

    return averageDifference;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        updateTableData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Seçilen Tarih: ${DateFormat('dd.MM.yyyy').format(selectedDate)}",
              style: TextStyle(fontSize: 14),
            ),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: _bakeryDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Bir hata oluştu: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("Veri bulunamadı."));
          } else {
            List<BakeryModel> bakeryList = snapshot.data as List<BakeryModel>;

            return Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  child: DataTable(
                    columns: [
                      DataColumn(
                          label: Text('FIRIN',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('EKMEK',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Devir Ekmek Sayısı',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: bakeryList.map((bakery) {
                      var serviceData = bakery.getEkmekSayisiByDate(
                          DateFormat('dd.MM.yyyy').format(selectedDate));
                      return DataRow(cells: [
                        DataCell(Text(bakery.firinIsmi)),
                        DataCell(Text(serviceData['ekmek_sayisi'].toString())),
                        DataCell(
                            Text(serviceData['devir_ekmek_sayisi'].toString())),
                      ]);
                    }).toList(),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    child: DataTable(
                      border: TableBorder.all(width: 2),
                      columns: firinbaslik.map((column) {
                        return DataColumn(
                          label: Text(
                            column,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
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
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

*/


import 'package:bakeryprojectapp/models/bakerymodel.dart';
import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/services/bakeryservices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BakeryAdminDistributionScreen extends StatefulWidget {
  final UserModel userModel;
  const BakeryAdminDistributionScreen({super.key, required this.userModel});

  @override
  State<BakeryAdminDistributionScreen> createState() =>
      _BakeryAdminDistributionScreenState();
}

class _BakeryAdminDistributionScreenState
    extends State<BakeryAdminDistributionScreen> {
  final BakeryServices _bakeryServices = BakeryServices();
  List<BakeryModel> bakeryList = [];
  Map<String, List<BakeryModel>> groupedBakeries = {};
  String selectedBolge = ''; // Seçilen bölge
  late Future<void> _bakeryDataFuture;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _bakeryDataFuture = fetchBakeryData();
  }

  Future<List<BakeryModel>> fetchBakeryData() async {
    try {
      var bakeries =
          await _bakeryServices.getAllBakeries(widget.userModel.rolsId);

      if (bakeries == null || bakeries.isEmpty) {
        throw Exception("Fırın verileri bulunamadı.");
      }

      setState(() {
        bakeryList = bakeries;
        groupBakeriesByBolge();
      });
      return bakeries;
    } catch (e) {
      print("Hata: $e");
      return [];
    }
  }

  void groupBakeriesByBolge() {
    groupedBakeries.clear();
    for (var bakery in bakeryList) {
      if (!groupedBakeries.containsKey(bakery.regionName)) {
        groupedBakeries[bakery.regionName] = [];
      }
      groupedBakeries[bakery.regionName]!.add(bakery);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dağıtım Ekranı"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Center(
            child: GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calendar_today, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "Seçilen Tarih: ${DateFormat('dd.MM.yyyy').format(selectedDate)}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButton<String>(
                value: selectedBolge.isEmpty ? null : selectedBolge,
                hint: Text('Bir bölge seçin'),
                isExpanded: true,
                underline: SizedBox(),
                items: groupedBakeries.keys.map((String bolge) {
                  return DropdownMenuItem<String>(
                    value: bolge,
                    child: Text(bolge),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBolge = value ?? '';
                  }); 
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder(
              future: _bakeryDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Bir hata oluştu: ${snapshot.error}"));
                } else if (!snapshot.hasData || selectedBolge.isEmpty) {
                  return Center(child: Text("Veri bulunamadı."));
                } else {
                  return ListView.builder(
                    itemCount: groupedBakeries[selectedBolge]!.length,
                    itemBuilder: (context, index) {
                      var bakery = groupedBakeries[selectedBolge]![index];
                      var serviceData = bakery.getEkmekSayisiByDate(
                          DateFormat('dd.MM.yyyy').format(selectedDate));

                      return Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bakery.firinIsmi,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Ekmek Sayısı: ${serviceData?['ekmek_sayisi']?.toString() ?? '-'}",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
