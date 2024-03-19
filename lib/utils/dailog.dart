import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../prvider/providerhtem.dart';

abstract class Showdailog{
  late Themprovider themprovider;
  static void showloding(BuildContext context){
    showDialog(barrierDismissible: false,context: context, builder: (context){
      return AlertDialog(
        content: Row(
          children: [
            Text("Loding..."),
            Spacer(),
            CircularProgressIndicator()
          ],
        ),
      );
    });
  }
  static void hideloding(BuildContext context){

   Navigator.pop(context);
  }
  static void showerror(BuildContext context,String massege){
    showDialog(barrierDismissible:false,context: context, builder: (context){
      return AlertDialog(
        title: Text("Error"),
        content: Text("$massege"),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("OK"))
        ],

      );
    });
  }
}