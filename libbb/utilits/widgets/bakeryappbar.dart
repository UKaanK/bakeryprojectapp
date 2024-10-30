
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
      leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_rounded,
            size: 40,
            color: Colors.blue,
          )),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
    );
  }
  
  @override
 @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  
}