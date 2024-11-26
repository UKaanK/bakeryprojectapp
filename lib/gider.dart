import 'package:bakeryprojectapp/models/usermodel.dart';
import 'package:bakeryprojectapp/services/driverservices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GiderPage extends StatefulWidget {
  final UserModel userModel;

  GiderPage({required this.userModel});

  @override
  _GiderPageState createState() => _GiderPageState();
}

class _GiderPageState extends State<GiderPage> {
  final TextEditingController yakitController = TextEditingController();
  final TextEditingController tutarController = TextEditingController();
  List<String> selectedOptions = [];
  bool showAdditionalOptions = false;
  final DriverServices driverServices = DriverServices();

  void _onOptionSelected(String option, bool selected) {
    setState(() {
      if (selected) {
        selectedOptions.add(option);
      } else {
        selectedOptions.remove(option);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    yakitController.addListener(() {
      setState(() {});
    });
  }

  void _saveGider() async {
    String yakitGideri = yakitController.text;
    String ekstraGider = tutarController.text;
    String ekstraGiderAciklama = selectedOptions.join(', ');

    // Kontrol yapıyoruz: Eğer checkbox seçiliyse tutar dolu olmalı, değilse yakıt dolu olmalı
    bool isCheckboxSelected = selectedOptions.isNotEmpty;
    if (isCheckboxSelected && ekstraGider.isNotEmpty) {
      await driverServices.saveOrUpdateGider(yakitGideri, ekstraGider,
          ekstraGiderAciklama, widget.userModel.rolsId);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gider kaydedildi.')));
      yakitController.clear();
      tutarController.clear();
      selectedOptions.clear();
    } else if (!isCheckboxSelected && yakitGideri.isNotEmpty) {
      await driverServices.saveOrUpdateGider(yakitGideri, ekstraGider,
          ekstraGiderAciklama, widget.userModel.rolsId);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gider kaydedildi.')));
      yakitController.clear();
      tutarController.clear();
      selectedOptions.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isCheckboxSelected
              ? 'Tutar girilmesi zorunlu.'
              : 'Yakıt girilmesi zorunlu.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isYakitFilled = yakitController.text.isNotEmpty;
    bool isOptionSelected = selectedOptions.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GİDER",
          style:GoogleFonts.cambo(
    fontSize: 35,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
        ),
        iconTheme: IconThemeData(color: Colors.blue, size: 30),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60,
                child: Row(
                  children: [
                    Text(
                      "YAKIT:",
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 6,
                      child: TextField(
                        controller: yakitController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '0',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 5, 5, 5),
                                width: 2.0),
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
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("DİĞER GİDERLER:", style: TextStyle(fontSize: 24)),
                      ],
                    ),
                    CheckboxListTile(
                      title: Text("ŞÖFÖR İHTİYACI"),
                      value: selectedOptions.contains("ŞÖFÖR İHTİYACI"),
                      onChanged: (bool? value) {
                        _onOptionSelected("ŞÖFÖR İHTİYACI", value!);
                      },
                    ),
                    CheckboxListTile(
                      title: Text("ARAÇ İHTİYACI"),
                      value: selectedOptions.contains("ARAÇ İHTİYACI"),
                      onChanged: (bool? value) {
                        _onOptionSelected("ARAÇ İHTİYACI", value!);
                      },
                    ),
                    CheckboxListTile(
                      title: Text("ARAÇ BAKIMI"),
                      value: selectedOptions.contains("ARAÇ BAKIMI"),
                      onChanged: (bool? value) {
                        _onOptionSelected("ARAÇ BAKIMI", value!);
                      },
                    ),
                    CheckboxListTile(
                      title: Text("YEMEK"),
                      value: selectedOptions.contains("YEMEK"),
                      onChanged: (bool? value) {
                        _onOptionSelected("YEMEK", value!);
                      },
                    ),
                    CheckboxListTile(
                      title: Text("DİĞER"),
                      value: selectedOptions.contains("DİĞER"),
                      onChanged: (bool? value) {
                        _onOptionSelected("DİĞER", value!);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60,
                child: Row(
                  children: [
                    Text(
                      "TUTAR:",
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 6,
                      child: TextField(
                        controller: tutarController,
                        enabled:
                            isOptionSelected, // Tutar girişi sadece seçenekler seçiliyse aktif
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '0',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 5, 5, 5),
                                width: 2.0),
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
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 55,
                child: ElevatedButton(
                  onPressed:
                      isYakitFilled || isOptionSelected ? _saveGider : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isYakitFilled || isOptionSelected
                        ? Colors.blue
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: Text(
                    "GİR",
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
