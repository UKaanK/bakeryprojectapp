import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RaporPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "RAPOR",
          style: TextStyle(fontSize: 30),
        ),
        iconTheme: IconThemeData(color: Colors.blue, size: 30),
      ),
      body: Column(
        children: [
          SizedBox(height: 4),
          Center(
            child: Text(
              formattedDate,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
