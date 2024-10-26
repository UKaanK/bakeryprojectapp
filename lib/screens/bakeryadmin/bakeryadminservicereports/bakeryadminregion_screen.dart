import 'package:bakeryprojectapp/screens/bakeryadmin/bakeryadminservicereports/bakeryadminreports_screen.dart';
import 'package:bakeryprojectapp/utilits/widgets/bakeryappbar.dart';
import 'package:flutter/material.dart';

class BakeryAdminRegionScreen extends StatefulWidget {
  const BakeryAdminRegionScreen({super.key});

  @override
  State<BakeryAdminRegionScreen> createState() =>
      _BakeryAdminRegionScreenState();
}

class _BakeryAdminRegionScreenState extends State<BakeryAdminRegionScreen> {
  List region = ["Ümraniye", "Çekmeköy", "Sultanbeyli", "Samandıra"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bakeryappbar(),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          height: MediaQuery.of(context).size.height,
          child: Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: region.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BakeryAdminReportsScreen(),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.height / 11,
                        color: Colors.blue,
                        child: Text(
                          "${region[index]}",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

