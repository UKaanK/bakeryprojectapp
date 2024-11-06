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

  void _showConfirmationDialog(BuildContext context) {
  int girilenEkmek = int.tryParse(_ekmekController.text) ?? 0;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Onay" , style: TextStyle(fontSize: 30 , color: Colors.blue  , fontWeight: FontWeight.bold,),),
        content: Text(
          "${girilenEkmek} ekmek girdiniz, emin misiniz?",
          style: TextStyle(fontSize: 23), // Dinamik olarak girilen değeri göster
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // "Hayır" tuşuna basınca çık
            },
            child: Text("Hayır" , style: TextStyle(fontSize: 20 , color: Colors.blue , fontWeight: FontWeight.bold),),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // "Evet" tuşuna basınca işlemi gerçekleştir
              _addBread();
            },
            child: Text("Evet" , style: TextStyle(fontSize: 20 , color: Colors.blue , fontWeight: FontWeight.bold),),
          ),
        ],
      );
    },
    
  );
}


  void _addBread() {
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
