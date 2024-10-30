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
  
  @override
  void initState() {
    super.initState();
    fetchRegionData();
  }
void fetchRegionData() async {
  RegionModel? regionData = await _regionService.getRegionData(widget.rolsId, widget.regionId);

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
          int value = int.tryParse(market.services[col]?.toString() ?? '0') ?? 0;
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
          total += (int.tryParse(market.services[col]?.toString() ?? '0') ?? 0);
        }
        totalRow.add(total.toString());
      }

      // Toplam satırına toplam hücresini ekle
      totalRow.add(rows.fold(0, (sum, row) => sum + (int.tryParse(row.last) ?? 0)).toString()); // Toplam satırının en sağındaki toplam

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
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
