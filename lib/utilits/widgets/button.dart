import 'package:flutter/material.dart';

Widget custom_button(BuildContext context, String text, VoidCallback onPressed) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.8,
    height: MediaQuery.of(context).size.height * 0.080,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 40),
      ),
    ),
  );
}

Widget custom_button1(BuildContext context, String text, VoidCallback onPressed) {
  return SizedBox(
    /*
    width: MediaQuery.of(context).size.width * 0.25,
    height: MediaQuery.of(context).size.height * 0.1,
    */
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 30),
      ),
    ),
  );
}


Widget customButton2(BuildContext context, String text, VoidCallback onPressed) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.8,
    height: MediaQuery.of(context).size.height * 0.07,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          Icon(
            Icons.location_on_outlined,
            color: Colors.white,
            size: 30,
          ),
        ],
      ),
    ),
  );
}