import 'package:flutter/material.dart';

class Settingprovider extends ChangeNotifier{
  String currentlocal='en';
  void setcurrentlocal(String newlocal){
    currentlocal=newlocal;
    notifyListeners();
  }
}