
import 'package:flutter/material.dart';

class bakeryappbar extends StatelessWidget implements PreferredSizeWidget{
  bool? centerTitle;
   Widget? title; 

   bakeryappbar({super.key ,this.title,this.centerTitle});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: centerTitle,
      titleTextStyle: const TextStyle(fontSize: 30 , color: Colors.black),
      leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 30,
            color: Colors.blue,
          )),
      automaticallyImplyLeading: false,
      
    );
  }
  
  @override
 @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  
}