/*
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  _ShellPageState createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  final TextEditingController _ekmekController = TextEditingController();
  int toplamEkmek = 300;
  int dagitilanEkmek = 0;
  int aractakiEkmek = 300;
  List<int> dagitilanEkmekler = [];

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "F(x) SHELL",
          style: TextStyle(fontSize: 30),
        ),
        iconTheme: IconThemeData(color: Colors.blue, size: 30),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 8),
            Center(
              child: Text(
                formattedDate,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            // Ekmek girişi
            Row(
              children: [
                Text(
                  "EKMEK:",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _ekmekController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '0',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 5, 5, 5), width: 2.0),
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
                  onPressed: aractakiEkmek > 0
                      ? () {
                          setState(() {
                            int girilenEkmek =
                                int.tryParse(_ekmekController.text) ?? 0;
                            if (girilenEkmek > 0) {
                              dagitilanEkmek += girilenEkmek;
                              aractakiEkmek -= girilenEkmek;
                              dagitilanEkmekler.add(girilenEkmek);
                              _ekmekController.clear();
                            }
                          });
                        }
                      : null, // Buton kitlenir (devre dışı kalır) eğer araçtaki ekmek 0 ise
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
              ],
            ),
            SizedBox(height: 20),
            // Dağıtılan ve Araçtaki ekmek göstergeleri
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dağıtılan ekmek: $dagitilanEkmek",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "Araçtaki ekmek: $aractakiEkmek",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Tablo
            Table(
              border: TableBorder.all(),
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(60),
              },
              children: [
                // İlk satır: S1, S2, ..., TOP
                TableRow(
                  children: List.generate(dagitilanEkmekler.length + 1, (index) {
                    if (index < dagitilanEkmekler.length) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'S${index + 1}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'TOP',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }
                  }),
                ),
                // İkinci satır: Dağıtılan ekmek miktarları ve toplam
                TableRow(
                  children: List.generate(dagitilanEkmekler.length + 1, (index) {
                    if (index < dagitilanEkmekler.length) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(dagitilanEkmekler[index].toString()),
                        ),
                      );
                    } else {
                      int toplamDagitilan = dagitilanEkmekler.fold(
                          0, (previousValue, element) => previousValue + element);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            toplamDagitilan.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

*/

/*

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  _ShellPageState createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  final TextEditingController _ekmekController = TextEditingController();
  int toplamEkmek = 300; // Başlangıçtaki toplam ekmek miktarı
  int dagitilanEkmek = 0; // Dağıtılan ekmek miktarı
  int aractakiEkmek = 300; // Araçtaki kalan ekmek miktarı
  List<int> dagitilanEkmekler = []; // Dağıtılan ekmek miktarlarının listesi
  List<Map<String, dynamic>> dagitimSaatleri =
      []; // Saat ve dağıtılan miktarın kaydı

  @override
  Widget build(BuildContext context) {
    // Şu anki tarihi biçimlendirilmiş şekilde alıyoruz
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "F(x) SHELL",
          style: TextStyle(fontSize: 30),
        ),
        iconTheme: IconThemeData(color: Colors.blue, size: 30),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 8),
              // Tarih göstergesi
              Center(
                child: Text(
                  formattedDate,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              // Ekmek girişi kısmı
              Row(
                children: [
                  Text(
                    "EKMEK:",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _ekmekController,
                      keyboardType: TextInputType.number,
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
                  SizedBox(width: 10),
                  // Ekmek miktarını eklemek için GİR butonu
                  ElevatedButton(
                    onPressed: aractakiEkmek > 0
                        ? () {
                            setState(() {
                              // Kullanıcının girdiği miktarı alıyoruz
                              int girilenEkmek =
                                  int.tryParse(_ekmekController.text) ?? 0;
                              if (girilenEkmek > 0) {
                                // Dağıtılan ve araçtaki ekmek miktarlarını güncelle
                                dagitilanEkmek += girilenEkmek;
                                aractakiEkmek -= girilenEkmek;
                                // Dağıtılan ekmek miktarını listeye ekle
                                dagitilanEkmekler.add(girilenEkmek);

                                // Saat ve miktarı kaydet
                                dagitimSaatleri.add({
                                  "saat": DateFormat('HH:mm')
                                      .format(DateTime.now()),
                                  "miktar": girilenEkmek
                                });

                                _ekmekController.clear();
                              }
                            });
                          }
                        : null, // Araçtaki ekmek 0 olduğunda buton devre dışı
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
                ],
              ),
              SizedBox(height: 20),
              // Dağıtılan ve Araçtaki ekmek miktarını gösteren bölümler
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dağıtılan ekmek: $dagitilanEkmek",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Araçtaki ekmek: $aractakiEkmek",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Dağıtılan ekmek miktarlarını gösteren tablo
              Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(60),
                },
                children: [
                  // İlk satır: S1, S2, ..., TOP
                  TableRow(
                    children:
                        List.generate(dagitilanEkmekler.length + 1, (index) {
                      if (index < dagitilanEkmekler.length) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'S${index + 1}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'TOP',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                  // İkinci satır: Dağıtılan ekmek miktarları ve toplam
                  TableRow(
                    children:
                        List.generate(dagitilanEkmekler.length + 1, (index) {
                      if (index < dagitilanEkmekler.length) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(dagitilanEkmekler[index].toString()),
                          ),
                        );
                      } else {
                        // Tüm dağıtılan ekmeklerin toplamı
                        int toplamDagitilan = dagitilanEkmekler.fold(
                            0,
                            (previousValue, element) =>
                                previousValue + element);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              toplamDagitilan.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Saat ve dağıtılan miktarı gösteren bar grafiği
              SizedBox(
                height: 400, // Grafik boyutu
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: toplamEkmek.toDouble(), // Grafikteki maksimum değer
                    barGroups: dagitimSaatleri.asMap().entries.map((entry) {
                      int index = entry.key;
                      int miktar = entry.value['miktar'];
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: miktar.toDouble(),
                            color: Colors.blue,
                            width: 16,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                        showingTooltipIndicators: [0],
                      );
                    }).toList(),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          getTitlesWidget: (value, meta) {
                            return Text(value.toInt().toString());
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            int index = value.toInt();
                            if (index >= 0 && index < dagitimSaatleri.length) {
                              return Text(dagitimSaatleri[index]["saat"],
                                  style: TextStyle(fontSize: 10));
                            }
                            return Text('');
                          },
                          reservedSize: 32,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 2),
                        left: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


*/

/*

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  _ShellPageState createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  final TextEditingController _ekmekController = TextEditingController();
  final TextEditingController _iadeController = TextEditingController();
  final TextEditingController _tahsilatController = TextEditingController();

  int toplamEkmek = 300;
  int dagitilanEkmek = 0;
  int aractakiEkmek = 300;
  int iadeMiktari = 0;
  int tahsilatMiktari = 0;

  List<int> dagitilanEkmekler = [];
  List<Map<String, dynamic>> dagitimSaatleri = [];

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "F(x) SHELL",
          style: TextStyle(fontSize: 30),
        ),
        iconTheme: IconThemeData(color: Colors.blue, size: 30),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 8),
              Center(
                child: Text(
                  formattedDate,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "EKMEK:",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _ekmekController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '0',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 5, 5, 5), width: 2.0),
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
                    onPressed: aractakiEkmek > 0
                        ? () {
                            setState(() {
                              int girilenEkmek =
                                  int.tryParse(_ekmekController.text) ?? 0;
                              if (girilenEkmek > 0) {
                                dagitilanEkmek += girilenEkmek;
                                aractakiEkmek -= girilenEkmek;
                                dagitilanEkmekler.add(girilenEkmek);
                                dagitimSaatleri.add({
                                  "saat": DateFormat('HH:mm').format(DateTime.now()),
                                  "miktar": girilenEkmek
                                });
                                _ekmekController.clear();
                              }
                            });
                          }
                        : null,
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
                ],
              ),
              SizedBox(height: 20),

              // Dağıtılan ekmek ve Araçtaki ekmek miktarını gösteren çerçeveli kısım
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.blueAccent, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dağıtılan ekmek: $dagitilanEkmek",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Araçtaki ekmek: $aractakiEkmek",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // İade İşlemi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "İADE:",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _iadeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '0',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        iadeMiktari = int.tryParse(_iadeController.text) ?? 0;
                        aractakiEkmek += iadeMiktari; 
                        _iadeController.clear();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      "İADE",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Tahsilat İşlemi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "TAHSİLAT:",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _tahsilatController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '0',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        tahsilatMiktari = int.tryParse(_tahsilatController.text) ?? 0;
                        _tahsilatController.clear();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      "GİR",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Grafiği Göster butonu en altta ortalanmış
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GraphPage(
                          dagitimSaatleri: dagitimSaatleri,
                          toplamEkmek: toplamEkmek,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    "Grafiği Göster",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class GraphPage extends StatelessWidget {
  final List<Map<String, dynamic>> dagitimSaatleri;
  final int toplamEkmek;

  const GraphPage({super.key, required this.dagitimSaatleri, required this.toplamEkmek});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dağıtım Grafiği"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              getDrawingHorizontalLine: (value) => FlLine(color: Colors.grey, strokeWidth: 0.5),
              getDrawingVerticalLine: (value) => FlLine(color: Colors.grey, strokeWidth: 0.5),
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  getTitlesWidget: (value, meta) => Text(value.toInt().toString()),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    int index = value.toInt();
                    if (index >= 0 && index < dagitimSaatleri.length) {
                      return Text(dagitimSaatleri[index]["saat"], style: TextStyle(fontSize: 10));
                    }
                    return Text('');
                  },
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.black, width: 2),
            ),
            minX: 0,
            maxX: (dagitimSaatleri.length - 1).toDouble(),
            minY: 0,
            maxY: toplamEkmek.toDouble(),
            lineBarsData: [
              LineChartBarData(
                spots: dagitimSaatleri.asMap().entries.map((entry) {
                  int index = entry.key;
                  int miktar = entry.value['miktar'];
                  return FlSpot(index.toDouble(), miktar.toDouble());
                }).toList(),
                isCurved: true,
                color: Colors.blue,
                barWidth: 3,
                belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
                dotData: FlDotData(show: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


*/





/*

import 'package:bakeryprojectapp/models/dagitimmodel.dart';
import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/services/dagitimservices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class ShellPage extends StatefulWidget {
  final UserModel userModel;
  final String marketIsim;
  final String servis;
  const ShellPage(
      {super.key,
      required this.userModel,
      required this.marketIsim,
      required this.servis});

  @override
  _ShellPageState createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  final TextEditingController _ekmekController = TextEditingController();
  final TextEditingController _iadeController = TextEditingController();
  final TextEditingController _tahsilatController = TextEditingController();
  DagitimService _dagitimService = DagitimService();
  DagitimModel? dagitimModel;
  bool isLoading = false;

  int toplamEkmek = 0;
  int dagitilanEkmek = 0;
  int aractakiEkmek = 600;
  int iadeMiktari = 0;
  int tahsilatMiktari = 0;

  List<int> dagitilanEkmekler = [];
  List<Map<String, dynamic>> dagitimSaatleri = [];
  @override
  void initState() {
    super.initState();
    _fetchDagitimData();
  }

  final tarih = DateFormat('dd.MM.yyyy').format(DateTime.now());

  Future<void> _fetchDagitimData() async {
    setState(() {
      isLoading = true;
    });

    // Örnek roleId ve tarih verilerini burada kullanıyoruz
    final roleId = widget.userModel.rolsId;
    final tarih = DateFormat('dd.MM.yyyy').format(DateTime.now());
    final marketIsim = widget.marketIsim; // ShellPage'e gelen market ismi
    print(tarih);
    // Veri çekme işlemi
    dagitimModel =
        await _dagitimService.getMarketByName(roleId, tarih, marketIsim);

    setState(() {
      isLoading = false;
    });
  }

  void _showConfirmationDialog(BuildContext context) {
    int girilenEkmek = int.tryParse(_ekmekController.text) ?? 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Onay",
            style: TextStyle(
              fontSize: 30,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "${girilenEkmek} ekmek girdiniz, emin misiniz?",
            style:
                TextStyle(fontSize: 23), // Dinamik olarak girilen değeri göster
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // "Hayır" tuşuna basınca çık
              },
              child: Text(
                "Hayır",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // "Evet" tuşuna basınca işlemi gerçekleştir
                _addBread();
              },
              child: Text(
                "Evet",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  void _addBread() async {
    print(widget.servis);

    // updateMarketEkmek'i çağırarak dağıtılan ekmek miktarını güncelleyin
    await _dagitimService.updateMarketEkmek(
        widget.userModel.rolsId,
        widget.marketIsim, // Güncellenen marketin adı
        _ekmekController.text, // Güncellenen dağıtılan ekmek miktarı
        // İade ekmek miktarı (örneğin 0 olarak belirlenmiş),
        widget.servis,
        tarih);

    setState(() {
      int girilenEkmek = int.tryParse(_ekmekController.text) ?? 0;
      if (girilenEkmek > 0 && aractakiEkmek > 0) {
        dagitilanEkmek += girilenEkmek;
        aractakiEkmek -= girilenEkmek;
        dagitilanEkmekler.add(girilenEkmek);
        dagitimSaatleri.add({
          "saat": DateFormat('HH:mm').format(DateTime.now()),
          "miktar": girilenEkmek
        });
        _ekmekController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.marketIsim}",
          style: TextStyle(fontSize: 30),
        ),
        iconTheme: IconThemeData(color: Colors.blue, size: 30),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : dagitimModel != null
              ? ListView.builder(
                  itemCount: dagitimModel!.market.length,
                  itemBuilder: (context, index) {
                    final market = dagitimModel!.market[index];
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(height: 8),
                            Center(
                              child: Text(
                                formattedDate,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "EKMEK:",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    controller: _ekmekController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: '0',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(255, 5, 5, 5),
                                            width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: aractakiEkmek > 0
                                      ? () {
                                          _showConfirmationDialog(context);
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  child: Text(
                                    "GİR",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            // Dağıtılan ekmek ve Araçtaki ekmek miktarını gösteren çerçeveli kısım
                            Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                    color: Colors.blueAccent, width: 1.5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dağıtılan ekmek: ${market.dagitilanEkmek}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Araçtaki ekmek: ${market.aractakiEkmek}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),

                            // İade İşlemi
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "İADE:",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: TextField(
                                    controller: _iadeController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: '0',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _dagitimService.updateMarketIadeEkmek(
                                          widget.userModel.rolsId,
                                          widget.marketIsim,
                                          _iadeController.text,
                                          tarih);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: Text(
                                    "İADE",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            // Tahsilat İşlemi
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "TAHSİLAT:",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextField(
                                    controller: _tahsilatController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: '0',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _dagitimService.saveOrUpdateTahsilat(
                                          widget.userModel.rolsId,
                                          widget.marketIsim,
                                          _tahsilatController.text,
                                          tarih);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: Text(
                                    "GİR",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            // Grafiği Göster butonu en altta ortalanmış
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GraphPage(
                                        dagitimSaatleri: dagitimSaatleri,
                                        toplamEkmek: toplamEkmek,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  "Grafiği Göster",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text("Veri bulunamadı veya hata oluştu."),
                ),
    );
  }
}

class GraphPage extends StatelessWidget {
  final List<Map<String, dynamic>> dagitimSaatleri;
  final int toplamEkmek;

  const GraphPage(
      {super.key, required this.dagitimSaatleri, required this.toplamEkmek});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dağıtım Grafiği"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              getDrawingHorizontalLine: (value) =>
                  FlLine(color: Colors.grey, strokeWidth: 0.5),
              getDrawingVerticalLine: (value) =>
                  FlLine(color: Colors.grey, strokeWidth: 0.5),
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  getTitlesWidget: (value, meta) =>
                      Text(value.toInt().toString()),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    int index = value.toInt();
                    if (index >= 0 && index < dagitimSaatleri.length) {
                      return Text(dagitimSaatleri[index]["saat"],
                          style: TextStyle(fontSize: 10));
                    }
                    return Text('');
                  },
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.black, width: 2),
            ),
            minX: 0,
            maxX: (dagitimSaatleri.length - 1).toDouble(),
            minY: 0,
            maxY: toplamEkmek.toDouble(),
            lineBarsData: [
              LineChartBarData(
                spots: dagitimSaatleri.asMap().entries.map((entry) {
                  int index = entry.key;
                  int miktar = entry.value['miktar'];
                  return FlSpot(index.toDouble(), miktar.toDouble());
                }).toList(),
                isCurved: true,
                color: Colors.blue,
                barWidth: 3,
                belowBarData: BarAreaData(
                    show: true, color: Colors.blue.withOpacity(0.3)),
                dotData: FlDotData(show: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





*/





/*


import 'package:bakeryprojectapp/models/dagitimmodel.dart';
import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/services/dagitimservices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ShellPage extends StatefulWidget {
  final UserModel userModel;
  final String marketIsim;
  final String servis;

  const ShellPage({
    super.key,
    required this.userModel,
    required this.marketIsim,
    required this.servis,
  });

  @override
  _ShellPageState createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  final TextEditingController _ekmekController = TextEditingController();
  final TextEditingController _iadeController = TextEditingController();
  final TextEditingController _tahsilatController = TextEditingController();
  final DagitimService _dagitimService = DagitimService();

  DagitimModel? dagitimModel;
  bool isLoading = false;

  final String tarih = DateFormat('dd.MM.yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _fetchDagitimData();
  }

  Future<void> _fetchDagitimData() async {
    setState(() {
      isLoading = true;
    });

    try {
      dagitimModel = await _dagitimService.getMarketByName(
        widget.userModel.rolsId,
        tarih,
        widget.marketIsim,
      );
    } catch (e) {
      print("Veri çekme hatası: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veri çekme işlemi başarısız!")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _addBread() async {
    final girilenEkmek = int.tryParse(_ekmekController.text) ?? 0;
    if (girilenEkmek <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Geçerli bir ekmek miktarı girin!")),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      await _dagitimService.updateMarketEkmek(
        widget.userModel.rolsId,
        widget.marketIsim,
        _ekmekController.text,
        widget.servis,
        tarih,
      );

      await _fetchDagitimData(); // Güncellenmiş verileri alarak ekranı yenile
      _ekmekController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ekmek güncellemesi başarılı!")),
      );
    } catch (e) {
      print("Ekmek güncelleme hatası: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ekmek güncelleme işlemi başarısız!")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateIade() async {
    final iade = int.tryParse(_iadeController.text) ?? 0;
    if (iade < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Geçerli bir iade miktarı girin!")),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      await _dagitimService.updateMarketIadeEkmek(
        widget.userModel.rolsId,
        widget.marketIsim,
        _iadeController.text,
        tarih,
      );

      await _fetchDagitimData(); // Güncellenmiş verileri alarak ekranı yenile
      _iadeController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("İade işlemi başarılı!")),
      );
    } catch (e) {
      print("İade güncelleme hatası: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("İade işlemi başarısız!")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateTahsilat() async {
    final tahsilat = int.tryParse(_tahsilatController.text) ?? 0;
    if (tahsilat < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Geçerli bir tahsilat miktarı girin!")),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      await _dagitimService.saveOrUpdateTahsilat(
        widget.userModel.rolsId,
        widget.marketIsim,
        _tahsilatController.text,
        tarih,
      );

      await _fetchDagitimData(); // Güncellenmiş verileri alarak ekranı yenile
      _tahsilatController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tahsilat işlemi başarılı!")),
      );
    } catch (e) {
      print("Tahsilat güncelleme hatası: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tahsilat işlemi başarısız!")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.marketIsim, style:GoogleFonts.cambo(
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : dagitimModel != null && dagitimModel!.market.isNotEmpty
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            formattedDate,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20),
                       
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "EKMEK:",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(width: 10),
                            Expanded(                  
                              child: TextField(
                                controller: _ekmekController,
                                keyboardType: TextInputType.number,
                               decoration: InputDecoration(
                                      hintText: '0',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                               ),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              
                              onPressed: _addBread,

                              style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: Text(
                                    "GİR",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                             
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "İADE:    ",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _iadeController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                      hintText: '0',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: _updateIade,
                              style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: Text(
                                    "İADE",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "TAHSİLAT:",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _tahsilatController,
                                keyboardType: TextInputType.number,
                               decoration: InputDecoration(
                                      hintText: '0',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1.5),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                               ),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: _updateTahsilat,
                             style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: Text(
                                    "GİR",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                            ),



                          ],
                        ),
                         

                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Center(
                            child: Container(
                                
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: Colors.blue, width: 1.5),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Dağıtılan ekmek: ${dagitimModel!.market[0].dagitilanEkmek ?? 0}",
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Araçtaki ekmek: ${dagitimModel!.market[0].aractakiEkmek ?? 0}",
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "İade edilen ekmek: ${dagitimModel!.market[0].iadeEkmek ?? 0}",
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Tahsilat: ${dagitimModel!.market[0].tahsilat ?? 0}",
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(child: Text("Veri bulunamadı.")),
    );
  }
}
*/







/*

import 'package:bakeryprojectapp/models/dagitimmodel.dart';
import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/services/dagitimservices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ShellPage extends StatefulWidget {
  final UserModel userModel;
  final String marketIsim;
  final String servis;

  const ShellPage({
    super.key,
    required this.userModel,
    required this.marketIsim,
    required this.servis,
  });

  @override
  _ShellPageState createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  final TextEditingController _ekmekController = TextEditingController();
  final TextEditingController _iadeController = TextEditingController();
  final TextEditingController _tahsilatController = TextEditingController();
  final DagitimService _dagitimService = DagitimService();

  DagitimModel? dagitimModel;
  bool isLoading = false;

  final String tarih = DateFormat('dd.MM.yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _fetchDagitimData();
  }

  Future<void> _fetchDagitimData() async {
    setState(() {
      isLoading = true;
    });

    try {
      dagitimModel = await _dagitimService.getMarketByName(
        widget.userModel.rolsId,
        tarih,
        widget.marketIsim,
      );
    } catch (e) {
      print("Veri çekme hatası: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veri çekme işlemi başarısız!") , backgroundColor: Colors.blue,),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _addBread() async {
    final girilenEkmek = int.tryParse(_ekmekController.text) ?? 0;
    if (girilenEkmek <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Geçerli bir ekmek miktarı girin!") , backgroundColor: Colors.blue,),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      await _dagitimService.updateMarketEkmek(
        widget.userModel.rolsId,
        widget.marketIsim,
        _ekmekController.text,
        widget.servis,
        tarih,
      );

      await _fetchDagitimData();
      _ekmekController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ekmek güncellemesi başarılı!"), backgroundColor: Colors.blue,),
      );
    } catch (e) {
      print("Ekmek güncelleme hatası: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ekmek güncelleme işlemi başarısız!") , backgroundColor: Colors.blue,),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateIade() async {
    final iade = int.tryParse(_iadeController.text) ?? 0;
    if (iade < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Geçerli bir iade miktarı girin!") , backgroundColor: Colors.blue,),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      await _dagitimService.updateMarketIadeEkmek(
        widget.userModel.rolsId,
        widget.marketIsim,
        _iadeController.text,
        tarih,
      );

      await _fetchDagitimData();
      _iadeController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("İade işlemi başarılı!"), backgroundColor: Colors.blue,),
      );
    } catch (e) {
      print("İade güncelleme hatası: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("İade işlemi başarısız!") , backgroundColor: Colors.blue,),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateTahsilat() async {
    final tahsilat = int.tryParse(_tahsilatController.text) ?? 0;
    if (tahsilat < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Geçerli bir tahsilat miktarı girin!") , backgroundColor: Colors.blue,),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      await _dagitimService.saveOrUpdateTahsilat(
        widget.userModel.rolsId,
        widget.marketIsim,
        _tahsilatController.text,
        tarih,
      );

      await _fetchDagitimData();
      _tahsilatController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tahsilat işlemi başarılı!") , backgroundColor: Colors.blue,),
      );
    } catch (e) {
      print("Tahsilat güncelleme hatası: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tahsilat işlemi başarısız!") , backgroundColor: Colors.blue,),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.marketIsim,
          style: GoogleFonts.cambo(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
         iconTheme: const IconThemeData(
    color: Colors.white, // Geri git butonunun rengini beyaz yapar
    size: 30
  ),
      ),

            body: isLoading
          ? Center(child: CircularProgressIndicator())
          : dagitimModel != null && dagitimModel!.market.isNotEmpty
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          label: "Ekmek",
                          controller: _ekmekController,
                          buttonText: "GİR",
                          onPressed: _addBread,
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          label: "İade",
                          controller: _iadeController,
                          buttonText: "İADE",
                          onPressed: _updateIade,
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          label: "Tahsilat",
                          controller: _tahsilatController,
                          buttonText: "GİR",
                          onPressed: _updateTahsilat,
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.blue,
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfoRow(
                                  label: "Dağıtılan ekmek:",
                                  value: "${dagitimModel!.market[0].dagitilanEkmek ?? 0}",
                                ),
                                _buildInfoRow(
                                  label: "Araçtaki ekmek:",
                                  value: "${dagitimModel!.market[0].aractakiEkmek ?? 0}",
                                ),
                                _buildInfoRow(
                                  label: "İade edilen ekmek:",
                                  value: "${dagitimModel!.market[0].iadeEkmek ?? 0}",
                                ),
                                _buildInfoRow(
                                  label: "Tahsilat:",
                                  value: "${dagitimModel!.market[0].tahsilat ?? 0}",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    "Veri bulunamadı.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
    );
  }

  Widget _buildInputField({
  required String label,
  required TextEditingController controller,
  required String buttonText,
  required VoidCallback onPressed,
}) {
  return Row(
    children: [
      SizedBox(
        width: 80, // Sabit genişlik ile etiketlerin hizalı olmasını sağlıyoruz
        child: Text(
          "$label:",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        flex: 3, // TextField'ın genişliği için ayar
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: '0',
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        flex: 2, // Butonun genişliği için ayar
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  );
}


  Widget _buildInfoRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}



*/



import 'package:bakeryprojectapp/models/dagitimmodel.dart';
import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/services/dagitimservices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ShellPage extends StatefulWidget {
  final UserModel userModel;
  final String marketIsim;
  final String servis;

  const ShellPage({
    super.key,
    required this.userModel,
    required this.marketIsim,
    required this.servis,
  });

  @override
  _ShellPageState createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  final TextEditingController _ekmekController = TextEditingController();
  final TextEditingController _iadeController = TextEditingController();
  final TextEditingController _tahsilatController = TextEditingController();
  final DagitimService _dagitimService = DagitimService();

  DagitimModel? dagitimModel;
  bool isLoading = false;

  final String tarih = DateFormat('dd.MM.yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _fetchDagitimData();
  }

  Future<void> _fetchDagitimData() async {
    setState(() {
      isLoading = true;
    });

    try {
      dagitimModel = await _dagitimService.getMarketByName(
        widget.userModel.rolsId,
        tarih,
        widget.marketIsim,
      );
    } catch (e) {
      print("Veri çekme hatası: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veri çekme işlemi başarısız!"), backgroundColor: Colors.blue),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _addBread() async {
    final girilenEkmek = int.tryParse(_ekmekController.text) ?? 0;
    if (girilenEkmek <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Geçerli bir ekmek miktarı girin!"), backgroundColor: Colors.blue),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      await _dagitimService.updateMarketEkmek(
        widget.userModel.rolsId,
        widget.marketIsim,
        _ekmekController.text,
        widget.servis,
        tarih,
      );

      await _fetchDagitimData();
      _ekmekController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ekmek güncellemesi başarılı!"), backgroundColor: Colors.blue),
      );
    } catch (e) {
      print("Ekmek güncelleme hatası: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ekmek güncelleme işlemi başarısız!"), backgroundColor: Colors.blue),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateIade() async {
    final iade = int.tryParse(_iadeController.text) ?? 0;
    if (iade < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Geçerli bir iade miktarı girin!"), backgroundColor: Colors.blue),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      await _dagitimService.updateMarketIadeEkmek(
        widget.userModel.rolsId,
        widget.marketIsim,
        _iadeController.text,
        tarih,
      );

      await _fetchDagitimData();
      _iadeController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("İade işlemi başarılı!"), backgroundColor: Colors.blue),
      );
    } catch (e) {
      print("İade güncelleme hatası: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("İade işlemi başarısız!"), backgroundColor: Colors.blue),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateTahsilat() async {
    final tahsilat = int.tryParse(_tahsilatController.text) ?? 0;
    if (tahsilat < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Geçerli bir tahsilat miktarı girin!"), backgroundColor: Colors.blue),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      await _dagitimService.saveOrUpdateTahsilat(
        widget.userModel.rolsId,
        widget.marketIsim,
        _tahsilatController.text,
        tarih,
      );

      await _fetchDagitimData();
      _tahsilatController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tahsilat işlemi başarılı!"), backgroundColor: Colors.blue),
      );
    } catch (e) {
      print("Tahsilat güncelleme hatası: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tahsilat işlemi başarısız!"), backgroundColor: Colors.blue),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.marketIsim,
          style: GoogleFonts.cambo(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : dagitimModel != null && dagitimModel!.market.isNotEmpty
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          label: "Ekmek",
                          controller: _ekmekController,
                          buttonText: "GİR",
                          onPressed: _addBread,
                          icon: Icons.bakery_dining,
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          label: "İade",
                          controller: _iadeController,
                          buttonText: "İADE",
                          onPressed: _updateIade,
                          icon: Icons.undo,
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          label: "Tahsilat",
                          controller: _tahsilatController,
                          buttonText: "GİR",
                          onPressed: _updateTahsilat,
                          icon: Icons.attach_money,
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.blue,
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfoRow(
                                  label: "Dağıtılan ekmek:",
                                  value: "${dagitimModel!.market[0].dagitilanEkmek ?? 0}",
                                ),
                                _buildInfoRow(
                                  label: "Araçtaki ekmek:",
                                  value: "${dagitimModel!.market[0].aractakiEkmek ?? 0}",
                                ),
                                _buildInfoRow(
                                  label: "İade edilen ekmek:",
                                  value: "${dagitimModel!.market[0].iadeEkmek ?? 0}",
                                ),
                                _buildInfoRow(
                                  label: "Tahsilat:",
                                  value: "${dagitimModel!.market[0].tahsilat ?? 0}",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    "Veri bulunamadı.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String buttonText,
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 24,
          color: Colors.blue,
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 80,
          child: Text(
            "$label:",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '0',
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
