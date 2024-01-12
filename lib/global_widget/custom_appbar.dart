import 'package:class20/const/all_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppbar {
  static PreferredSizeWidget appbar({
    bool isTitle = false, bool isLeading = false, String title = '', List<Widget>? actions 
  }) {
    return AppBar(  
      //toolbarHeight: 80,
      centerTitle: true, 
      automaticallyImplyLeading: false,
      leading: isLeading? IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios, color: AllColors.textBlackColor, size: 18,)) : null,  
      title: isTitle ? Text(title, style: TextStyle(fontSize: 20, color: AllColors.textBlackColor, fontWeight: FontWeight.w700),): null, 
      actions: actions
    );
  }
}
