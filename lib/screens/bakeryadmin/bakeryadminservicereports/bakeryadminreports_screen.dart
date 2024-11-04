import 'package:bakeryprojectapp/models/regionmodel.dart';
import 'package:bakeryprojectapp/services/regionservices.dart';
import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:flutter/material.dart';

class BakeryAdminReportsScreen extends StatefulWidget {
  final String rolsId;
  final String regionId;

  const BakeryAdminReportsScreen(
      {super.key, required this.rolsId, required this.regionId});

  @override
  State<BakeryAdminReportsScreen> createState() =>
      _BakeryAdminReportsScreenState();
}

class _BakeryAdminReportsScreenState extends State<BakeryAdminReportsScreen> {
  final RegionService _regionService = RegionService();

  List<String> columns = ['Market', 'Toplam'];
  List<List<String>> rows = [];
  
  

  @override
  void initState() {
    super.initState();
    fetchRegionData();
  }

  void fetchRegionData() async {
    RegionModel? regionData =
        await _regionService.getRegionData(widget.rolsId, widget.regionId);

    if (regionData != null) {
      setState(() {
        // Servis anahtarlarını bir küme (set) olarak al ve sıralı liste oluştur
        Set<String> allServiceKeys = {};
        for (var market in regionData.market) {
          allServiceKeys.addAll(market.services.keys);
        }
        // Anahtarları sıralı bir listeye dönüştür
        List<String> dynamicColumns = allServiceKeys.toList();
        dynamicColumns.sort(); // Anahtarları alfabetik sıralama

        columns = ['Market', ...dynamicColumns, 'Toplam'];

        // Satır verilerini ayarla
        rows = regionData.market.map((market) {
          List<String> row = [market.name];
          int rowTotal = 0; // Satır toplamı için değişken
          for (var col in dynamicColumns) {
            int value =
                int.tryParse(market.services[col]?.toString() ?? '0') ?? 0;
            row.add(value.toString()); // Servis değerlerini al
            rowTotal += value; // Satır toplamını güncelle
          }
          row.add(rowTotal.toString()); // Satır toplamını ekle
          return row;
        }).toList();

        // Toplam satırını ekle
        List<String> totalRow = ['Toplam'];
        for (var col in dynamicColumns) {
          // Her bir hizmet için toplam hesapla
          int total = 0;
          for (var market in regionData.market) {
            total +=
                (int.tryParse(market.services[col]?.toString() ?? '0') ?? 0);
          }
          totalRow.add(total.toString());
        }

        // Toplam satırına toplam hücresini ekle
        totalRow.add(rows
            .fold(0, (sum, row) => sum + (int.tryParse(row.last) ?? 0))
            .toString()); // Toplam satırının en sağındaki toplam

        // Toplam satırını ekleyin
        rows.add(totalRow);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bakeryappbar(),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            border: TableBorder.all(width: 2),
            columnSpacing: 15.0,
            columns: columns.map((column) {
              return DataColumn(
                label: Text(
                  column,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              );
            }).toList(),
            rows: rows.map((row) {
              return DataRow(
                cells: row.map((cell) {
                  return DataCell(
                    Text(cell, textAlign: TextAlign.start),
                  );
                }).toList(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

*/


/*
import 'package:bakeryprojectapp/models/regionmodel.dart';
import 'package:bakeryprojectapp/services/regionservices.dart';
import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:flutter/material.dart';

class BakeryAdminReportsScreen extends StatefulWidget {
  final String rolsId;
  final String regionId;

  const BakeryAdminReportsScreen({super.key, required this.rolsId, required this.regionId});

  @override
  State<BakeryAdminReportsScreen> createState() => _BakeryAdminReportsScreenState();
}

class _BakeryAdminReportsScreenState extends State<BakeryAdminReportsScreen> {
  final RegionService _regionService = RegionService();

  List<String> columns = ['Market', 'Toplam'];
  List<List<String>> rows = [];
  List<String> totalRow = ['Toplam']; // Genel toplam satırı

  @override
  void initState() {
    super.initState();
    fetchRegionData();
  }

  void fetchRegionData() async {
    RegionModel? regionData = await _regionService.getRegionData(widget.rolsId, widget.regionId);

    if (regionData != null) {
      setState(() {
        Set<String> allServiceKeys = {};
        for (var market in regionData.market) {
          allServiceKeys.addAll(market.services.keys);
        }
        List<String> dynamicColumns = allServiceKeys.toList()..sort();
        columns = ['Market', ...dynamicColumns, 'Toplam'];

        rows = regionData.market.map((market) {
          List<String> row = [market.name];
          int rowTotal = 0;
          for (var col in dynamicColumns) {
            int value = int.tryParse(market.services[col]?.toString() ?? '0') ?? 0;
            row.add(value.toString());
            rowTotal += value;
          }
          row.add(rowTotal.toString()); // Her market için toplamı ekle
          return row;
        }).toList();

        // Genel toplam hesaplama
        totalRow = ['Toplam'];
        for (var col in dynamicColumns) {
          int columnTotal = regionData.market.fold(0, (sum, market) {
            return sum + (int.tryParse(market.services[col]?.toString() ?? '0') ?? 0);
          });
          totalRow.add(columnTotal.toString());
        }
        
        // En sağdaki genel toplamı hesapla
        int grandTotal = rows.fold(0, (sum, row) => sum + (int.tryParse(row.last) ?? 0));
        totalRow.add(grandTotal.toString()); // Genel toplamı ekle

        rows.add(totalRow); // Genel toplam satırını tablonun sonuna ekle
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bakeryappbar(title: Text(widget.regionId)),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            border: TableBorder.all(width: 2, color: Colors.grey.shade300),
            columnSpacing: 30.0,
            headingRowColor: WidgetStateProperty.resolveWith((states) => Colors.blueAccent),
            headingTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18,
            ),
            columns: columns.map((column) {
              return DataColumn(
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(column),
                ),
              );
            }).toList(),
            rows: rows.asMap().entries.map((entry) {
              int index = entry.key;
              List<String> row = entry.value;
              return DataRow(
                color: WidgetStateProperty.resolveWith(
                  (states) => index == rows.length - 1
                      ? Colors.lightBlue.shade100 // Genel toplam satırı için farklı renk
                      : index % 2 == 0
                          ? Colors.grey.shade100
                          : Colors.white,
                ),
                cells: row.map((cell) {
                  return DataCell(
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                      child: Text(
                        cell,
                        textAlign: TextAlign.start,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: index == rows.length - 1 ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}


*/




import 'package:bakeryprojectapp/models/regionmodel.dart';
import 'package:bakeryprojectapp/services/regionservices.dart';
import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:flutter/material.dart';

class BakeryAdminReportsScreen extends StatefulWidget {
  final String rolsId;
  final String regionId;

  const BakeryAdminReportsScreen({super.key, required this.rolsId, required this.regionId});

  @override
  State<BakeryAdminReportsScreen> createState() => _BakeryAdminReportsScreenState();
}

class _BakeryAdminReportsScreenState extends State<BakeryAdminReportsScreen> {
  final RegionService _regionService = RegionService();
  List<Map<String, dynamic>> marketData = [];

  @override
  void initState() {
    super.initState();
    fetchRegionData();
  }

  void fetchRegionData() async {
    RegionModel? regionData = await _regionService.getRegionData(widget.rolsId, widget.regionId);

    if (regionData != null) {
      setState(() {
        marketData = regionData.market.map((market) {
          Map<String, int> services = {};

          // Her hizmeti ayrı ayrı kaydet
          market.services.forEach((key, value) {
            int serviceValue = int.tryParse(value.toString()) ?? 0;
            services[key] = serviceValue;
          });

          return {
            'marketName': market.name,
            'services': services,
          };
        }).toList();
      });
    }
  }

  int calculateMarketTotal(Map<String, int> services) {
    // Belirli bir marketteki tüm hizmetlerin toplamını hesapla
    return services.values.fold(0, (sum, value) => sum + value);
  }

  int calculateGeneralTotal() {
    // marketData'daki tüm marketlerin hizmet toplamlarını hesapla
    return marketData.fold(0, (sum, market) => sum + calculateMarketTotal(market['services'] as Map<String, int>));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bakeryappbar(title: Text(widget.regionId)),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: marketData.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: marketData.length,
                      itemBuilder: (context, index) {
                        final data = marketData[index];
                        final marketTotal = calculateMarketTotal(data['services'] as Map<String, int>);

                        return Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.store,
                                          color: Colors.blueAccent,
                                          size: 22,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          data['marketName'],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down_circle,
                                      color: Colors.grey.shade400,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Column(
                                  children: (data['services'] as Map<String, int>).entries.map((entry) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          entry.key,
                                          style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                                        ),
                                        Text(
                                          entry.value.toString(),
                                          style: TextStyle(fontSize: 16, color: Colors.grey.shade900),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.attach_money,
                                          color: Colors.green,
                                          size: 20,
                                        ),
                                        Text(
                                          'Toplam',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      marketTotal.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
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
          ),
          // Genel toplam göstergesi
          Card(
            color: Color.fromARGB(255, 78, 214, 255),
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Genel Toplam',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    calculateGeneralTotal().toString(), // Dinamik olarak genel toplamı hesapla
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



